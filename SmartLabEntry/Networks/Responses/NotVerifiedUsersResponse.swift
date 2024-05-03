//
//  NotVerifiedUsersResponse.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Foundation

struct NotVerifiedUsersResponse: Codable {
    var notVerifiedUsers: [NotVerifiedUser]

    struct NotVerifiedUser: Codable {
        var userId: String
        var firstName: String
        var lastName: String
        var schoolId: String
        var email: String
    }
}
