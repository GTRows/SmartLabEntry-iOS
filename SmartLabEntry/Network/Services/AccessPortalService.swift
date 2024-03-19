//
//  AccessPortalService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Alamofire
import Foundation

//static let getAllAccessPortals = "\(accessPath)/my-all"
//static let getAccessiblePortals = "\(accessPath)"
//static let getPortalStatus = "\(accessPath)/portal-status"
//static let enterAccessPortal = "\(accessPath)enter"
//static let exitAccessPortal = "\(accessPath)/exit"
//static let resetDoor = "\(accessPath)/reset-reader"

class AccessPortalService {
    static let shared = AccessPortalService()
    private init() {}
    
    func getAllAccessPortals(completion: @escaping (Result<[AccessPortalModel], Error>) -> Void) {
        BaseService.shared.sendRequest(to: ApiPath.getAllAccessPortals, method: .get, useToken: true) { result in
            BaseService.shared.processResponse(result: result, completion: completion)
        }
    }
    
    func getAccessiblePortals(completion: @escaping (Result<[AccessPortalModel], Error>) -> Void) {
        BaseService.shared.sendRequest(to: ApiPath.getAccessiblePortals, method: .get, useToken: true) { result in
            BaseService.shared.processResponse(result: result, completion: completion)
        }
    }
    
}
