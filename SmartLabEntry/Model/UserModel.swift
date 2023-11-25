//
//  UserModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import Foundation

struct UserModel: Codable {
    private var id: String
    private var firstName: String
    private var lastName: String
    private var email: String

    private var schoolId: String
    private var role: RoleType
    private var isVerified: Bool
    private var isRFIDVerified: Bool

    init(id: String, firstName: String, lastName: String, email: String, schoolId: String, role: RoleType, isVerified: Bool, isRFIDVerified: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email

        self.schoolId = schoolId
        self.role = role
        self.isVerified = isVerified
        self.isRFIDVerified = isRFIDVerified
    }

    init?(from dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let email = dict["email"] as? String,

              let schoolId = dict["cardId"] as? String,
              let roleRawValue = dict["role"] as? String, let role = RoleType(rawValue: roleRawValue),
              let isVerified = dict["isVerified"] as? Bool,
              let isRFIDVerified = dict["isRFIDVerified"] as? Bool else {
            return nil
        }

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email

        self.schoolId = schoolId
        self.role = role
        self.isVerified = isVerified
        self.isRFIDVerified = isRFIDVerified
    }

    func getId() -> String {
        return id
    }

    func getFirstName() -> String {
        return firstName
    }

    func getLastName() -> String {
        return lastName
    }

    func getEmail() -> String {
        return email
    }

    func getSchoolId() -> String {
        return schoolId
    }

    func getRole() -> RoleType {
        return role
    }

    func getIsVerified() -> Bool {
        return isVerified
    }

    func getIsRFIDVerified() -> Bool {
        return isRFIDVerified
    }

    func toDict() -> [String: Any] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "schoolId": schoolId,
            "role": role.rawValue,
            "isVerified": isVerified,
            "isRFIDVerified": isRFIDVerified,
        ]
    }
}
