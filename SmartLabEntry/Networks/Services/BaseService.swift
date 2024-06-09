//
//  APIService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Alamofire
import Foundation

struct BaseService {
    static func sendRequest(
        to endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        useToken: Bool = true,
        completion: @escaping (Result<(statusCode: Int, responseString: String?), Error>) -> Void
    ) {
        let completeEndpoint = ApiPath.baseUrl + endpoint
        let actualHeaders = headers ?? HTTPHeaders()

        func performRequestWithHeaders(_ updatedHeaders: HTTPHeaders) {
            AF.request(completeEndpoint, method: method, parameters: parameters, encoding: encoding, headers: updatedHeaders).responseData { response in
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                    return
                }
                let responseString = String(data: response.data ?? Data(), encoding: .utf8)
                DispatchQueue.main.async {
                    completion(.success((statusCode, responseString)))
                }
            }
        }

        if useToken {
            NetworkUtility.getAuthToken { result in
                switch result {
                case let .success(token):
                    var authHeaders = actualHeaders
                    authHeaders.addBearerToken(token)
                    performRequestWithHeaders(authHeaders)
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else {
            performRequestWithHeaders(actualHeaders)
        }
    }
    
    enum NetworkError: Error {
        case errorMessages(statusCode: Int, message: String)
        case invalidResponseData

        var localizedDescription: String {
            switch self {
            case .errorMessages(let statusCode, let message):
                return "Status Code: \(statusCode), Message: \(message)"
            case .invalidResponseData:
                return "Invalid response data"
            }
        }
    }

    static func processResponse<T: Decodable>(
        result: Result<(statusCode: Int, responseString: String?), Error>,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        switch result {
        case .success(let (statusCode, responseString)):
            guard let responseString = responseString, let data = responseString.data(using: .utf8) else {
                completion(.failure(NetworkError.invalidResponseData))
                return
            }
            print("response: ")
            print(responseString)
            if let statusCodeResult = handleResponseStatusCode(statusCode: statusCode, message: responseString), statusCodeResult {
                do {
                    let jsonData = responseString.data(using: .utf8)!
                    let decodedResponse = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedResponse))
                } catch let DecodingError.dataCorrupted(context) {
                    print("Data corrupted: \(context.debugDescription)")
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: "Data corrupted: \(context.debugDescription)")))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: "Key '\(key)' not found: \(context.debugDescription)")))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: "Value '\(value)' not found: \(context.debugDescription)")))
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: "Type '\(type)' mismatch: \(context.debugDescription)")))
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: error.localizedDescription)))
                }
            } else {
                completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: responseString)))
            }
        case let .failure(error):
            completion(.failure(error))
        }
    }

    private static func handleResponseStatusCode(statusCode: Int, message: String) -> Bool? {
        switch statusCode {
        case 200 ... 299:
            return true
        default:
            return nil
        }
    }
}
