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

    static func processResponse<T: Decodable>(
        result: Result<(statusCode: Int, responseString: String?), Error>,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        switch result {
        case .success(let (statusCode, responseString)):
            guard let responseString = responseString, let data = responseString.data(using: .utf8) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response data"])))
                return
            }
            if let statusCodeResult = handleResponseStatusCode(statusCode: statusCode, message: responseString), statusCodeResult {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(NetworkError.errorMessages(statusCode: statusCode, message: responseString)))
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
