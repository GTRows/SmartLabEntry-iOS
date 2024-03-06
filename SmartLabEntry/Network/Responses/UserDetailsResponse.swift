//
//  MyDetailResponse.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 6.03.2024.
//

import Foundation


struct UserDetailsResponse: Codable {
    var userId: String
    var firstName: String
    var lastName: String
    var schoolId: String
    var email: String
    var role: RoleType
    var isVerified: Bool
    var rfidCardId: String?
}
