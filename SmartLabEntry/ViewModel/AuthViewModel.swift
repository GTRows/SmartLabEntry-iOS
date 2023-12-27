//
//  AuthViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 10.12.2023.
//

import FirebaseAuth
import Foundation
import SwiftUI
//
class AuthViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isUserLoggedIn: Bool = false
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var schoolId: String = ""
    @Published var email: String = "admin@gmail.com"
    @Published var password: String = "1234.Five"
    @Published var confirmPassword: String = ""

    private let auth = Auth.auth()

    init() {}

    func validateLoginPage() -> Bool {
        if !Validators.isValidEmail(email) {
            print("Email is not valid.")
            AlertService.shared.showString(title: "Error", message: "Email is not valid.")
            return false
        }
        if !Validators.isValidPassword(password) {
            print("Password is not valid.")
            AlertService.shared.showString(title: "Error", message: "Password is not valid.")
            return false
        }

        return true
    }

    func validateFirstPage() -> Bool {
        if name.isEmpty || surname.isEmpty {
            print("First name and last name cannot be empty.")
            AlertService.shared.showString(title: "Error", message: "First name and last name cannot be empty.")
            return false
        }

        if !Validators.isNumeric(schoolId) || schoolId.count != 9 {
            print("School ID must be a 9-digit number.")

            print("School ID: \(schoolId)")
            print("School ID count: \(schoolId.count)")
            print("School ID is numeric: \(Validators.isNumeric(schoolId))")

            AlertService.shared.showString(title: "Error", message: "School ID must be a 9-digit number.")
            return false
        }

        return true
    }

    func validateSecondPage() -> Bool {
        if !Validators.isValidEmail(email) {
            print("Email is not valid.")
            AlertService.shared.showString(title: "Error", message: "Email is not valid.")
            return false
        }

        if !Validators.isValidPassword(password) {
            print("Password is not valid.")
            AlertService.shared.showString(title: "Error", message: "Password is not valid.")
            return false
        }

        if password != confirmPassword {
            print("Passwords do not match.")
            AlertService.shared.showString(title: "Error", message: "Passwords do not match.")
            return false
        }
        return true
    }

    func signUp() {
//        TODO: control is user already registered with mail or school id or name and surname on backend

        let requestBody = [
            "firstName": name,
            "lastName": surname,
            "schoolId": schoolId,
            "email": email,
            "password": password,
        ]

        UserSessionService.shared.createUser(requestBody: requestBody) { Result in
            switch Result {
            case let .success(message):
                print(message)
                AlertService.shared.showString(title: "Register successfull", message: message)
            case let .failure(error):
                print(error)
                AlertService.shared.show(error: error)
            }
        }
    }

    func signIn() {
        // Validate the input fields
        guard validateLoginPage() else {
            return
        }

        // Call the signIn method from UserSessionService
        UserSessionService.shared.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case let .success(message):
                print(message)
                AlertService.shared.showString(title: "Success", message: "You are now logged in.")

                // Retrieve the bearer token
                UserSessionService.shared.getBearerToken { tokenResult in
                    switch tokenResult {
                    case let .success(token):
                        print("Bearer Token: \(token)")

                        // Copy the token to the clipboard
                        UIPasteboard.general.string = token

                        // Notify the user that the token has been copied
                        DispatchQueue.main.async {
                            // Sign out the user
                            UserSessionService.shared.signOut()
                            self?.isUserLoggedIn = false
                            self?.user = nil

                            AlertService.shared.showString(title: "Token Copied", message: "Bearer token copied to clipboard. Logging out...")
                        }

                    case let .failure(error):
                        print("Error retrieving token: \(error.localizedDescription)")
                    }
                }

            case let .failure(error):
                print(error.localizedDescription)
                AlertService.shared.showString(title: "Error", message: "Login failed: \(error.localizedDescription)")
            }
        }
    }

//    func signIn() {
//        // Validate the input fields
//        guard validateLoginPage() else {
//            return
//        }
//
//        // Call the signIn method from UserSessionService
//        UserSessionService.shared.loginUser(email: email, password: password) { [weak self] result in
//            switch result {
//            case .success(let message):
//                print(message)
//                AlertService.shared.showString(title: "Success", message: "You are now logged in.")
//
//                // Retrieve the bearer token
//                UserSessionService.shared.getBearerToken { tokenResult in
//                    switch tokenResult {
//                    case .success(let token):
//                        print("Bearer Token: \(token)")
//                    case .failure(let error):
//                        print("Error retrieving token: \(error.localizedDescription)")
//                    }
//
//                    // Update the UI to reflect the user is logged in
//                    DispatchQueue.main.async {
//                        self?.isUserLoggedIn = true
//                        self?.user = UserSessionService.shared.getUser()
//                    }
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//                AlertService.shared.showString(title: "Error", message: "Login failed: \(error.localizedDescription)")
//            }
//        }
//    }
}
