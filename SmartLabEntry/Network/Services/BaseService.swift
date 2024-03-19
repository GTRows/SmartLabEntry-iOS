//
//  APIService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Alamofire
import FirebaseAuth
import Foundation

class BaseService {
    static let shared = BaseService()
    private init() {}

    func sendRequest(
        to endpoint: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        useToken: Bool = true,
        completion: @escaping (Result<(statusCode: Int, responseString: String?), Error>) -> Void
    ) {
        if useToken {
            guard let _ = Auth.auth().currentUser else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])))
                return
            }
            Auth.auth().currentUser?.getIDToken(completion: { token, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let token = token else {
                    completion(.failure(AFError.explicitlyCancelled))
                    return
                }

                var authHeaders = headers ?? HTTPHeaders()
                authHeaders.add(name: "Authorization", value: "Bearer \(token)")
                self.performRequest(to: endpoint, method: method, parameters: parameters, encoding: encoding, headers: authHeaders, completion: completion)
            })
        } else {
            performRequest(to: endpoint, method: method, parameters: parameters, encoding: encoding, headers: headers, completion: completion)
        }
    }

    private func performRequest(
        to endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        completion: @escaping (Result<(statusCode: Int, responseString: String?), Error>) -> Void
    ) {
        AF.request(ApiPath.baseUrl + endpoint, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { response in
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

    func handleResponseStatusCode(statusCode: Int, message: String) -> Result<Bool, NetworkError> {
        switch statusCode {
        case 200 ... 299:
            return .success(true)
        case 400:
            return .failure(.badRequest(statusCode: statusCode, message: message))
        case 401:
            return .failure(.unauthorized)
        case 403:
            return .failure(.forbidden)
        case 404:
            return .failure(.notFound)
        case 500 ... 599:
            return .failure(.serverError)
        default:
            return .failure(.errorMessages(statusCode: statusCode, message: message))
        }
    }

    func processResponse<T: Decodable>(
        result: Result<(statusCode: Int, responseString: String?), Error>,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        switch result {
        case let .success(response):
            let statusCodeResult = BaseService.shared.handleResponseStatusCode(statusCode: response.statusCode, message: response.responseString!)
            switch statusCodeResult {
            case .success:
                guard let responseString = response.responseString, let data = responseString.data(using: .utf8) else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response data"])))
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(NetworkError.errorMessages(statusCode: response.statusCode, message: response.responseString!)))
                }
            case let .failure(networkError):
                completion(.failure(networkError))
            }
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
