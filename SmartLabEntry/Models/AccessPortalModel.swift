//
//  AccessPortalModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 20.11.2023.
//

import Foundation

struct AccessPortalModel: Codable, Equatable, Hashable {
    var id: String
    var name: String
    var open: Bool
    var maxCapacity: Int
    var currentUsers: [CurrentUserModel]
    var avatar: String

    static func == (lhs: AccessPortalModel, rhs: AccessPortalModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.open == rhs.open &&
            lhs.maxCapacity == rhs.maxCapacity &&
            lhs.currentUsers == rhs.currentUsers &&
            lhs.avatar == rhs.avatar
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(open)
        hasher.combine(maxCapacity)
        hasher.combine(avatar)
    }
}
