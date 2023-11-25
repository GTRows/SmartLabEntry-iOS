//
//  AccessPortalModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 20.11.2023.
//

import Foundation

struct AccessPortalModel: Codable{
    var name: String
    var isOpen: Bool
    var currentUsersId: [String]
    
}
