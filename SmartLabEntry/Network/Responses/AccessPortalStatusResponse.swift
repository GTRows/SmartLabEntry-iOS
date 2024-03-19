//
//  AccessPortalsAccessibleResponse.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Foundation

struct AccessPortalStatusResponse: Codable {
    var accessPortalInfo: AccessPortalInfoDTO
    var activeUsers: [ActiveUserDTO]
}

struct AccessPortalInfoDTO: Codable {
    var name: String
    var isOpen: Bool
    var currentCapacity: Int
    var maxCapacity: Int
    var avatarUrl: String
    var isInside: Bool
}

struct ActiveUserDTO: Codable {
    var userId: String
    var userName: String
    var userEnterDate: String
}
