//
//  ResetPortalRequest.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Foundation

struct ResetPortalRequest: Codable {
    var accessPortalId: String
    var isInside: Bool
}
