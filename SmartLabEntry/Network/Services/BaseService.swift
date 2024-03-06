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

    func handleResponseStatusCode(_ statusCode: Int, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        switch statusCode {
        case 200, 201:
            completion(.success(()))
        case 400:
            completion(.failure(.invalidResponse))
        case 403:
            completion(.failure(.forbidden))
        default:
            completion(.failure(.unexpectedStatusCode(statusCode: statusCode, message: "")))
        }
    }
}
