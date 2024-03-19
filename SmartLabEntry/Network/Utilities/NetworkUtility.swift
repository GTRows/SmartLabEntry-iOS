//
//  NetworkUtility.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Alamofire
import FirebaseAuth
import Foundation

struct NetworkUtility {
    static func encodeRequest<T: Encodable>(_ request: T) -> Parameters? {
        do {
            let jsonData = try JSONEncoder().encode(request)
            return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Parameters
        } catch {
            print("Error encoding request: \(error.localizedDescription)")
            return nil
        }
    }

    static func getAuthToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])))
            return
        }
        user.getIDToken { token, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let token = token else {
                completion(.failure(NSError(domain: "AuthError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Token could not be retrieved"])))
                return
            }
            completion(.success(token))
        }
    }
}
