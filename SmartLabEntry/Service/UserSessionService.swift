//
//  UserSessionService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.11.2023.
//

import FirebaseAuth

import Foundation
import SwiftUI

class UserSessionService: ObservableObject {
    private init() {}
    static let shared = UserSessionService()

//    let storage = Storage.storage()
    private var firebaseUser: FirebaseAuth.User?
    private var user: UserModel?

    private let auth = Auth.auth()

    @AppStorage("uid") var userID: String = ""
//
//    private var user: UserModel?
//    private var authUser: FirebaseAuth.User?
//

//
//    @State var isLoggedIn: Bool = false

    // MARK: - User Operations

    func getUser() -> UserModel {
        if let user = user {
            return user
        }

        guard (Auth.auth().currentUser?.uid) != nil else {
            return Constants.defaultUser
        }

        // TODO: - Fetch user from api

        // Else

//        return userStorageService.fetchUser()
        return Constants.defaultUser
    }

    func createUser(requestBody: [String: Any], completition: @escaping (Result<String, Error>) -> Void) {
        APIService.shared.registerUser(requestBody: requestBody) { Result in
            switch Result {
            case let .success(message):
                completition(.success(message))
            case let .failure(error):
                completition(.failure(error))
            }
        }
    }

    func loginUser(email: String, password: String, completition: @escaping (Result<String, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completition(.failure(error))
            } else if let authResult = authResult {
//                TODO: Get data from api
                self.firebaseUser = authResult.user
                self.userID = authResult.user.uid
                print("User signed in.")
                completition(.success("User signed in."))
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        setUserID(id: "")
        user = nil
        firebaseUser = nil
    }
    
    func forgotPassword(email: String , completition: @escaping (Result<String, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
                completition(.failure(error))
            } else {
                print("Password reset email sent.")
                completition(.success("Password reset email sent."))
            }
        }
    }

    func setUserID(id: String) {
        withAnimation {
            self.userID = id
        }
    }

    func getBearerToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let authUser = firebaseUser else {
            completion(.failure(NSError(domain: "UserSessionService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found."])))
            return
        }
        authUser.getIDToken { token, error in
            if let error = error {
                completion(.failure(error))
            } else if let token = token {
                completion(.success(token))
            }
        }
    }

    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
}
