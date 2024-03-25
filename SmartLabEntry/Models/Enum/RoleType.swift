//
//  RoleType.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.11.2023.
//

import Foundation

enum RoleType: String, Codable {
    case MASTER = "MASTER"
    case ADMIN = "ADMIN"
    case ACADEMIC_STAFF = "ACADEMIC_STAFF"
    case STUDENT = "STUDENT"
    case GUEST = "GUEST"
    case UNKNOWN = "UNKNOWN"
}
