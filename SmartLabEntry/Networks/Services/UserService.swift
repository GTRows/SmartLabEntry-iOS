//
//  UserService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Alamofire
import Foundation

struct UserService {
    static func registerApi(userRegistrationRequest: UserRegistrationRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(userRegistrationRequest) {
            BaseService.sendRequest(to: ApiPath.registerApi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: false) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }

    static func getUserDetails(completion: @escaping (Result<UserDetailsResponse, Error>) -> Void) {
        BaseService.sendRequest(to: ApiPath.getMyUser, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }

    static func getUserStatus(completion: @escaping (Result<UserStatusResponse, Error>) -> Void) {
        BaseService.sendRequest(to: ApiPath.getMyStatus, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }
}
