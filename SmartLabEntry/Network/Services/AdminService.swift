//
//  AdminService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Alamofire
import Foundation

// static let openCloseAccessPortal = "\(adminPath)\(accessPath)/open-close-portal"
// static let onLearningMode = "\(adminPath)\(accessPath)/on-learning-mode"
// static let offLearningMode = "\(adminPath)\(accessPath)/off-learning-mode"
// static let getUnknownRfid = "\(adminPath)\(accessPath)/get-unknown-rfid"
// static let assignUnknownRfid = "\(adminPath)\(accessPath)/assign-unknown-rfid"
// static let kickUser = "\(adminPath)\(accessPath)/kick-user"

struct AdminService {
    static func getNotVerifiedUsers(completion: @escaping (Result<NotVerifiedUsersResponse, Error>) -> Void) {
        BaseService.sendRequest(to: ApiPath.getNotVerifiedUsers, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }

    static func assignRfid(assignRfidRequest: AssignRfidRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(assignRfidRequest) {
            BaseService.sendRequest(to: ApiPath.assignRfid, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func verifyUser(verifyUserRequest: VerifyUserRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(verifyUserRequest) {
            BaseService.sendRequest(to: ApiPath.verifyUser, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func getAllUsers(completion: @escaping (Result<[UserDetailsResponse], Error>) -> Void) {
        BaseService.sendRequest(to: ApiPath.getAllUsers, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }
    
    static func openDoor(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.openDoor, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func openCloseAccessPortal(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.openCloseAccessPortal, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func onLearningMode(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.onLearningMode, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func offLearningMode(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.offLearningMode, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func getUnknownRfid(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.getUnknownRfid, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    w
    static func assignUnknownRfid(assignRfidRequest: AssignRfidRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(assignRfidRequest) {
            BaseService.sendRequest(to: ApiPath.assignUnknownRfid, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
    static func kickUser(userAccessPortalRequest: UserAccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(userAccessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.kickUser, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
    
}
