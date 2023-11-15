//
//  UserSessionViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import FirebaseAuth
import Foundation

class UserSessionViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    static let shared = UserSessionViewModel()

    private init() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    func signOut() {
        try? Auth.auth().signOut()
        isLoggedIn = false
    }

    func signIn(email: String, password: String, completition: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let user = authResult?.user {
                strongSelf.isLoggedIn = true
//                completition(.success(user))
                completition(.success("test"))
            } else {
                completition(.failure(error!))
            }
        }
    }
}