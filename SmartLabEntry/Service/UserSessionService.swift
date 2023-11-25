//
//  UserSessionService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.11.2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class UserSessionService {
    static let shared = UserSessionService()
    private var user: UserModel?
    private var authUser: FirebaseAuth.User?

    private let auth = Auth.auth()

    private init() {
        authUser = auth.currentUser
    }

    func createUser(requestBody: [String: Any], completition: @escaping (Result<String, Error>) -> Void) {
        APIService.shared.registerUser(requestBody: requestBody) { Result in
            switch Result {
            case let .success(message):
                completition(.success(message))
                print(message)
            case let .failure(error):
                completition(.failure(error))
            }
        }
    }

    func signIn(email: String, password: String, completition: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completition(.failure(error))
            } else if let authResult = authResult {
//                TODO: Get data from api
                
                if true {
                    if let authUser = self?.auth.currentUser {
                        self?.authUser = authUser
                    }
                }
            }
        }
    }

    func getBearerToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let authUser = authUser else {
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
