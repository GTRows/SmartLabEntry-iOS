//
//  CardModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.11.2023.
//

import Foundation

struct CardModel: Codable {
    var name: String
    var isOpen: Bool
    var currentUsers: [UserModel]
    var currentCapacity: Int
    var maxCapacity: Int
}
