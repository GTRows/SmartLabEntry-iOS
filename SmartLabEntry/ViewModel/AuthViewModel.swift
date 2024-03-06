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
    @Published var name: String = "TestRemoveMe"
    @Published var surname: String = "TestRemoveMePls"
    @Published var schoolId: String = "123123123"
    @Published var email: String = "aciroglu.fatih@gmail.com"
    @Published var password: String = "1234.Five"
    @Published var confirmPassword: String = "1234.Five"
    @Published var isLogin = 0

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

        let requestBody: UserRegistrationRequest = UserRegistrationRequest(
            firstName: name,
            lastName: surname,
            schoolId: schoolId,
            email: email,
            password: password
        )

        UserService.shared.registerApi(userRegistrationRequest: requestBody) { [weak self] result in
            switch result {
            case let .success(message):
                print(message)
                AlertService.shared.showString(title: "Success", message: "You are now registered.")
                self?.isLogin = 1
            case let .failure(error):
                print(error.localizedDescription)
                AlertService.shared.showString(title: "Error", message: "Registration failed: \(error.localizedDescription)")
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
                    case let .failure(error):
                        print("Error retrieving token: \(error.localizedDescription)")
                    }

                    // Update the UI to reflect the user is logged in
                    DispatchQueue.main.async {
                        self?.isUserLoggedIn = true
                        self?.user = UserSessionService.shared.getUser()
                    }
                }

            case let .failure(error):
                print(error.localizedDescription)
                AlertService.shared.showString(title: "Error", message: "Login failed: \(error.localizedDescription)")
            }
        }
    }

    func forgotPassword() {
        // Validate the input fields
        print("forgot Email: \(email)")
        guard Validators.isValidEmail(email) else {
            print("Email is not valid.")
            AlertService.shared.showString(title: "Error", message: "Email is not valid.")
            return
        }

        // Call the forgotPassword method from UserSessionService
        UserSessionService.shared.forgotPassword(email: email) { result in
            switch result {
            case let .success(message):
                print(message)
                AlertService.shared.showString(title: "Success", message: "Password reset email sent.")
                withAnimation {
                    self.isLogin = 0
                }
            case let .failure(error):
                print(error.localizedDescription)
                AlertService.shared.showString(title: "Error", message: "Password reset failed: \(error.localizedDescription)")
            }
        }
    }
}
