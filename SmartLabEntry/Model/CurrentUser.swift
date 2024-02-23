//
//  CurrentUser.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 4.02.2024.
//

import Foundation

class CurrentUserModel: Codable{
    var userId: String
    var userName: String
    var userEnteredTime: Date
    
    init(userId: String, userName: String, userEnteredTime: Date) {
        self.userId = userId
        self.userName = userName
        self.userEnteredTime = userEnteredTime
    }
}
