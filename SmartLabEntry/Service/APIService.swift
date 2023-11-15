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

    private lazy var baseURL: URL = {
        APIService.getBaseURL() ?? URL(string: "http://localhost:8080")!
    }()

    private init() {}

    private static func getBaseURL() -> URL? {
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let urlString = dict["BaseURL"] as? String,
              let url = URL(string: urlString) else {
            return nil
        }
        return url
    }

//    func makeRequest(to path: APIPath, method: String, body: [String: Any]?, completion: @escaping (Result<String, Error>) -> Void) {
//        let url = Constants().getApiURL().appendingPathComponent(path.rawValue)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = method
//
//        if let body = body {
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            } catch {
//                completion(.failure(error))
//                return
//            }
//        }
//
//        // ... URLSession ile isteği gerçekleştirme
//    }

    func registerUser(requestBody: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("auth/register")
        print("latest url: \(url)")
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

                if data != nil {
                    completion(.success("Register successfull"))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
