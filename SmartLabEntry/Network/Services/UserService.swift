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

            BaseService.shared.sendRequest(to: ApiPath.registerApi, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: false) { result in
                BaseService.shared.processResponse(result: result, completion: completion)
            }
        } catch {
            completion(.failure(error))
        }
    }


    func getUserDetails(completion: @escaping (Result<UserDetailsResponse, Error>) -> Void) {
        BaseService.shared.sendRequest(to: ApiPath.getMyUser, method: .get, useToken: true) { result in
            BaseService.shared.processResponse(result: result, completion: completion)
        }
    }

}
