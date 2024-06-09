//
//  APIPath.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Foundation

struct ApiPath {
    static let baseUrl = "http://192.168.18.42:8080/api"

    // Auth API
    static let registerApi = "/auth/register"

    // USERS API
    static private let usersPath = "/users"
    static let getMyUser = "\(usersPath)"
    static let getMyStatus = "\(usersPath)/my-status"


    // ACCESS PORTALS API
    static private let accessPath = "/access-portals"
    static let getAllAccessPortals = "\(accessPath)/my-all"
    static let getAccessiblePortals = "\(accessPath)"
    static let getPortalStatus = "\(accessPath)/portal-status"
    static let enterAccessPortal = "\(accessPath)enter"
    static let exitAccessPortal = "\(accessPath)/exit"
    static let resetDoor = "\(accessPath)/reset-reader"

    // ADMIN API
    static private let adminPath = "/admin"
    static let getNotVerifiedUsers = "\(adminPath)/not-verified-user"
    static let assignRfid = "\(adminPath)/assign-rfid"
    static let verifyUser = "\(adminPath)/verify-user"
    static let getAllUsers = "\(adminPath)/get-all-users"
    static let openDoor = "\(adminPath)\(accessPath)/open-access-portal"
    static let openCloseAccessPortal = "\(adminPath)\(accessPath)/open-close-portal"
    static let onLearningMode = "\(adminPath)\(accessPath)/on-learning-mode"
    static let offLearningMode = "\(adminPath)\(accessPath)/off-learning-mode"
    static let getUnknownRfid = "\(adminPath)\(accessPath)/get-unknown-rfid"
    static let assignUnknownRfid = "\(adminPath)\(accessPath)/assign-unknown-rfid"
    static let kickUser = "\(adminPath)\(accessPath)/kick-user"
}

