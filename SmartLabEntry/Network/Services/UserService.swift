//
//  UserService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Alamofire
import Foundation

class UserService {
    static let shared = UserService()
    private init() {}

    func registerApi(userRegistrationRequest: UserRegistrationRequest, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(userRegistrationRequest)
            let parameters = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Parameters

            BaseService.shared.sendRequest(to: ApiPath.registerApi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: false) { result in
                switch result {
                case let .success(response):
                    guard let responseDict = StringConverter.convertToDictionary(from: response.responseString ?? "") else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert response data to dictionary"])))
                        return
                    }
                    BaseService.shared.handleResponseStatusCode(response.statusCode) { responseResult in
                        switch responseResult {
                        case .success:
                            completion(.success(""))
                        case let .failure(error):
                            completion(.failure(error))
                        }
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
