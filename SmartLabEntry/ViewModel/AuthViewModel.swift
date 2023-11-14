//
//  AuthViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import FirebaseAuth
import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isUserLoggedIn: Bool = false
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var schoolId: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    private let auth = Auth.auth()

    init() {
        auth.addStateDidChangeListener(handleAuthStateChange)
    }

    func handleAuthStateChange(_ auth: Auth, _ user: User?) {
        self.user = user
        isUserLoggedIn = user != nil
    }

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

    func signIn() {
        print("Email: \(email)")
        print("Password: \(password)")
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                print(error)
                AlertService.shared.show(error: error)
            } else {
                if let user = result?.user {
                    self?.user = user
                    // Token'ı al ve yazdır
                    user.getIDToken { token, error in
                        if let error = error {
                            print("Error fetching token: \(error.localizedDescription)")
                        } else if let token = token {
                            print("Bearer Token: \(token)")
                        }
                    }
                }
            }
            self?.isUserLoggedIn = self?.user != nil
        }
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

        APIService.shared.registerUser(requestBody: requestBody) { Result in
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
}
