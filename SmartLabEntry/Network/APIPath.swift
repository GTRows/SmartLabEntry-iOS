//
//  APIPath.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Foundation

struct ApiPath {
    static let baseUrl = "https://lab.alperen.keenetic.link/api"

    // Auth API
    static let registerApi = "/auth/register"

    // USERS API
    static let getMyUser = "/users"

    // ACCESS PORTALS API
    static let getAllAccessPortals = "/access-portals/my-all"
    static let getAccessiblePortals = "/access-portals"
    static let getPortalStatus = "/access-portals/portal-status"
    static let enterAccessPortal = "/access-portals/enter"
    static let exitAccessPortal = "/access-portals/exit"
    static let resetDoor = "/access-portals/reset-reader"

    // ADMIN API
    static let getNotVerifiedUsers = "/admin/not-verified-user"
    static let assignRfid = "/admin/assign-rfid"
    static let verifyUser = "/admin/verify-user"
    static let getAllUsers = "/users/all"
    static let openDoor = "/admin/open-access-portal"
    static let openCloseAccessPortal = "/admin/access-portals/open-close-portal"
    static let onLearningMode = "/admin/access-portals/on-learning-mode"
    static let offLearningMode = "/admin/access-portals/off-learning-mode"
    static let getUnknownRfid = "/admin/access-portals/get-unknown-rfid"
    static let assignUnknownRfid = "/admin/access-portals/assign-unknown-rfid"
}

