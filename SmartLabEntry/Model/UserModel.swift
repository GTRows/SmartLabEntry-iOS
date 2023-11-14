//
//  UserModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import Foundation

struct UserModel: Codable {
    var id: String
    var name: String
    var email: String
    var avatar: String

    init(id: String, name: String, email: String, avatar: String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
    }

    init?(from dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let name = dict["name"] as? String,
              let email = dict["email"] as? String,
              let avatar = dict["avatar"] as? String else {
            return nil
        }

        self.id = id
        self.name = name
        self.email = email
        self.avatar = avatar
    }

    func toDict() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "avatar": avatar,
        ]
    }
}
