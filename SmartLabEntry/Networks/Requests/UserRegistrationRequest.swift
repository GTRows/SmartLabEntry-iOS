//
//  UserRegistrationRequest.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Foundation

struct UserRegistrationRequest: Codable {
    var firstName: String
    var lastName: String
    var schoolId: String
    var email: String
    var password: String
}
