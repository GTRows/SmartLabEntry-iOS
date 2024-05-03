//
//  AssignRfidRequest.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Foundation

struct AssignRfidRequest: Codable {
    var userId: String
    var cardUID: String
    var cardType: CardType
}
