//
//  VerifyUserRequest.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Foundation

struct VerifyUserRequest: Codable{
    var userId: String
    var performVerification: Bool
    var role: RoleType
}
