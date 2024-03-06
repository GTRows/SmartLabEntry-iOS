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

    func registerApi(userRegistrationRequest: UserRegistrationRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        do {
            let jsonData = try JSONEncoder().encode(userRegistrationRequest)
            let parameters = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Parameters

            BaseService.shared.sendRequest(to: ApiPath.registerApi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: false) { apiResult in
                switch apiResult {
                case let .success(response):
                    BaseService.shared.handleResponseStatusCode(response.statusCode) { responseResult in
                        switch responseResult {
                        case .success:
                            guard let responseData = response.responseString?.toData() else {
                                completion(.failure(NetworkError.failedToConvertResponseDataToDictionary))
                                return
                            }
                            do {
                                let genericResponse = try JSONDecoder().decode(GenericResponse.self, from: responseData)
                                completion(.success(genericResponse))
                            } catch {
                                completion(.failure(error))
                            }
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

    func getUserDetails(completion: @escaping (Result<UserDetailsResponse, Error>) -> Void) {
        BaseService.shared.sendRequest(to: ApiPath.getMyUser, method: .get, useToken: true) { apiResult in
            switch apiResult {
            case let .success(response):
                BaseService.shared.handleResponseStatusCode(response.statusCode) { responseResult in
                    switch responseResult {
                    case .success:
                        guard let responseData = response.responseString?.toData() else {
                            completion(.failure(NetworkError.failedToConvertResponseDataToDictionary))
                            return
                        }
                        do {
                            let userDetails = try JSONDecoder().decode(UserDetailsResponse.self, from: responseData)
                            completion(.success(userDetails))
                        } catch {
                            completion(.failure(error))
                        }
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// do {
//    BaseService.shared.sendRequest(to: ApiPath.getMyUser, method: .get, useToken: true) { result in
//        switch result {
//        case let .success(response):
//            guard let responseDict = StringConverter.convertToDictionary(from: response.responseString ?? "") else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert response data to dictionary"])))
//                return
//            }
//            BaseService.shared.handleResponseStatusCode(response.statusCode) { responseResult in
//                switch responseResult {
//                case .success:
//                    completion(.success(""))
//                case let .failure(error):
//                    completion(.failure(error))
//                }
//            }
//        case let .failure(error):
//            completion(.failure(error))
//        }
//    }
// } catch {
//    completion(.failure(error))
// }
