//
//  FirebaseService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation
import UIKit

class FireBaseService {
    private init() {}
    static let shared = FireBaseService()
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    private var user: UserModel?
    
    private var userStorageService: UserStorageService = UserStorageService.shared
    
    private var _avatarImage: UIImage?
    
    // MARK: - User Operations
    
    func createUser(user: UserModel, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                var userWithId = user
                userWithId.id = authResult.user.uid
                let userData: [String: Any] = userWithId.toDict()
                self.db.collection("Users").document(authResult.user.uid).setData(userData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self.user = userWithId
                        self.userStorageService.saveUser(user: userWithId)
                        //                        ImageStorageService.shared.store(image: FireBaseService.shared.getAvatar(), for: user.id)
                        completion(.success(userWithId))
                    }
                }
            }
        }
    }
    
    func getUser() -> UserModel {
        if let user = user {
            return user
        }
        
        guard let authID = Auth.auth().currentUser?.uid else {
            return UserModel(id: "error", name: "error", email: "error", avatar: "error")
        }
        
        let docRef = db.collection("Users").document(authID)
        
        docRef.getDocument { document, _ in
            if let document = document, document.exists {
                let data = document.data()
                self.user = UserModel(from: data ?? [:])
                self.userStorageService.saveUser(user: self.user!)
            } else {
                print("Document does not exist")
            }
        }
        return userStorageService.fetchUser()
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                let docRef = self.db.collection("Users").document(authResult.user.uid)
                docRef.getDocument { document, _ in
                    if let document = document, document.exists {
                        let data = document.data()
                        if let user = UserModel(from: data ?? [:]) {
                            self.user = user
                            self.userStorageService.saveUser(user: user)
                            completion(.success(user))
                        }
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User does not exist"])))
                    }
                }
            }
        }
    }
    
    func updateUser(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let authID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid auth user"])))
            return
        }
        
        let userData: [String: Any] = user.toDict()
        
        db.collection("Users").document(authID).updateData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.user = user
                self.userStorageService.saveUser(user: user)
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Image Operations
    
    func uploadImage(_ image: UIImage, path: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image"])))
            return
        }
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("\(path)/\(UUID().uuidString).jpg")
        
        imageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                imageRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url.absoluteString))
                        self._avatarImage = nil
                    }
                }
            }
        }
    }
    
    func getAvatar(completionHandler: @escaping (UIImage?) -> Void) {
        if let cachedImage = _avatarImage {
            completionHandler(cachedImage)
            return
        }
        
        let url = getUser().avatar
        let reference = self.storage.reference(forURL: url)
        reference.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            if let data = data, let downloadedImage = UIImage(data: data) {
                self._avatarImage = downloadedImage
                completionHandler(downloadedImage)
            } else {
                completionHandler(UIImage(systemName: "brain.head.profile"))
            }
        }
    }
    
    func fetchImage(from url: String, completion: @escaping (UIImage) -> Void) {
        let storageRef = storage.reference(forURL: url)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(UIImage(named: "defaultPackage")!) // Default image
            }
        }
    }
}
