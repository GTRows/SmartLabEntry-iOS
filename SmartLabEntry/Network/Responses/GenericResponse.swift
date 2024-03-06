//
//  GenericResponse.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 6.03.2024.
//

import Foundation

struct GenericResponse: Codable {
    var message: String
    var timestamp: String
    var status: String
}
