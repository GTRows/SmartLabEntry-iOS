//
//  CurrentUser.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 4.02.2024.
//

import Foundation

class CurrentUserModel: Codable, Equatable {
    var userId: String
    var userName: String
    var userEnterTime: Date

    init(userId: String, userName: String, userEnteredTime: Date) {
        self.userId = userId
        self.userName = userName
        userEnterTime = userEnteredTime
    }

    static func == (lhs: CurrentUserModel, rhs: CurrentUserModel) -> Bool {
        return lhs.userId == rhs.userId &&
            lhs.userName == rhs.userName &&
            lhs.userEnterTime == rhs.userEnterTime
    }

    // Custom Date Formatter
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS" // Match the JSON format
        return formatter
    }()

    enum CodingKeys: String, CodingKey {
        case userId
        case userName
        case userEnterTime = "userEnterTime" // Correct the key name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        userId = try container.decode(String.self, forKey: .userId)
        userName = try container.decode(String.self, forKey: .userName)

        // Decode userEnteredTime as a String and then convert to Date
        let userEnterTimeString = try container.decode(String.self, forKey: .userEnterTime)
        userEnterTime = CurrentUserModel.dateFormatter.date(from: userEnterTimeString) ?? Date()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(userId, forKey: .userId)
        try container.encode(userName, forKey: .userName)

        // Encode userEnteredTime as a string in the expected format
        let userEnterTimeString = CurrentUserModel.dateFormatter.string(from: userEnterTime)
        try container.encode(userEnterTimeString, forKey: .userEnterTime)
    }
}
