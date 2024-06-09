//
//  AccessPortalService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Alamofire
import Foundation

struct AccessPortalService {
    static func getAllAccessPortals(completion: @escaping (Result<[AccessPortalModel], Error>) -> Void) {
        BaseService.sendRequest(to: ApiPath.getAllAccessPortals, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }

    static func getAccessiblePortals(completion: @escaping (Result<[AccessPortalsAccessibleResponse], Error>) -> Void) {
        // Do not use
        BaseService.sendRequest(to: ApiPath.getAccessiblePortals, method: .get, useToken: true) { result in
            BaseService.processResponse(result: result, completion: completion)
        }
    }

    static func getPortalStatus(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<AccessPortalStatusResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.getPortalStatus, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }

    static func enterAccessPortal(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
            BaseService.sendRequest(to: ApiPath.enterAccessPortal, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }

    static func exitAccessPortal(accessPortalRequest: AccessPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
       if let parameters = NetworkUtility.encodeRequest(accessPortalRequest) {
           BaseService.sendRequest(to: ApiPath.exitAccessPortal, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
               BaseService.processResponse(result: result, completion: completion)
           }
       } else {
           completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
       }
    }

    static func resetDoor(resetPortalRequest: ResetPortalRequest, completion: @escaping (Result<GenericResponse, Error>) -> Void) {
        if let parameters = NetworkUtility.encodeRequest(resetPortalRequest) {
            BaseService.sendRequest(to: ApiPath.resetDoor, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, useToken: true) { result in
                BaseService.processResponse(result: result, completion: completion)
            }
        } else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request"])))
        }
    }
}
