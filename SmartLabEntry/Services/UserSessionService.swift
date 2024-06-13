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
    private init() {
        firebaseUser = Auth.auth().currentUser
        userID = firebaseUser?.uid ?? ""
    }

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

        UserService.getUserDetails { result in
            switch result {
            case let .success(userDetails):
                self.user = UserModel(id: userDetails.userId, firstName: userDetails.firstName, lastName: userDetails.lastName, email: userDetails.email, schoolId: userDetails.schoolId, role: userDetails.role, isVerified: userDetails.isVerified)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        return Constants.defaultUser
    }

    func createUser(requestBody: [String: Any], completition: @escaping (Result<String, Error>) -> Void) {
//        UserRegistrationRequest request = UserRegistrationRequest(firstName: requestBody["firstName"] as! String, lastName: requestBody["lastName"] as! String, email: requestBody["email"] as! String, password: requestBody["password"] as! String, schoolId: requestBody["schoolId"] as! String)
//
//        UserService.registerApi(userRegistrationRequest: requestBody) { result in
//            switch result {
//            case .success:
//                completition(.success("User created."))
//            case let .failure(error):
//                print(error.localizedDescription)
//                completition(.failure(error))
//            }
//        }, completion: T##(Result<GenericResponse, any Error>) -> Void)
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
                
                UserService.getUserStatus { result in
                    switch result {
                    case let .success(userStatus):
                        if userStatus.isVerified {
                            print("User is verified.")
                            self.getUser()
                        } else {
                            print("User is not verified.")
                        }
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
                
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

    func forgotPassword(email: String, completition: @escaping (Result<String, Error>) -> Void) {
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
