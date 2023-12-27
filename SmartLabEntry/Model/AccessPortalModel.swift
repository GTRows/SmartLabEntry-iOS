//
//  AccessPortalModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 20.11.2023.
//

import Foundation

struct AccessPortalModel: Codable, Equatable, Hashable {
    var name: String
    var isOpen: Bool
    var maxCapacity: Int
    var currentUsersId: [String]
    var logoName: String // TODO: change to logoUrl
}
