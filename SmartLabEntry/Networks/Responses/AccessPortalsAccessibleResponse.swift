//
//  AccessPortalsAccessibleResponse.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 9.06.2024.
//

import Foundation

struct AccessPortalsAccessibleResponse: Codable {
    var mainAccessPortalsStatus: MainAccessPortalStatusResponse
    var otherAccessPortalsStatus: [OtherAccessPortalStatusResponseDTO]

    struct MainAccessPortalStatusResponse: Codable {
        var id: String
        var name: String
        var maxCapacity: Int
        var currentCapacity: Int
        var isOpen: Bool
        var currentUsers: [CurrentUserModel]
        var avatarUrl: String

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case maxCapacity
            case currentCapacity
            case isOpen = "open"
            case currentUsers
            case avatarUrl
        }
    }

    struct OtherAccessPortalStatusResponseDTO: Codable {
        var id: String
        var name: String
        var maxCapacity: Int
        var currentCapacity: Int
        var isOpen: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case maxCapacity
            case currentCapacity
            case isOpen = "open"
        }
    }
}
