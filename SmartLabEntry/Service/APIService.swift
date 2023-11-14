//
//  APIService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Foundation

// Spring boot api servce
class APIService {
    static let shared = APIService()

    private init() {}

    func registerUser(requestBody: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let url = Constants().getApiURL().appendingPathComponent("auth/register")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            let body = try JSONSerialization.data(withJSONObject: requestBody, options: .fragmentsAllowed)
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success("Register successfull"))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
