////
////  APIService.swift
////  SmartLabEntry
////
////  Created by Fatih Acıroğlu on 15.11.2023.
////
//
//import Foundation
//
//// Spring boot api servce
//class APIService {
//    static let shared = APIService()
//    
//    private init() {}
//
////    func makeRequest(to path: APIPath, method: String, body: [String: Any]?, completion: @escaping (Result<String, Error>) -> Void) {
////        let url = Constants().getApiURL().appendingPathComponent(path.rawValue)
////
////        var request = URLRequest(url: url)
////        request.httpMethod = method
////
////        if let body = body {
////            do {
////                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
////                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////            } catch {
////                completion(.failure(error))
////                return
////            }
////        }
////
////        // ... URLSession ile isteği gerçekleştirme
////    }
//
//    func registerUser(requestBody: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
//        let url = URL(string: APIPath.registerApi.urlString)!
////        print("latest url: \(url.rawValue)")
////        var request = URLRequest(url: URL(string: url.rawValue)!)
//        request.httpMethod = "POST"
//
//        do {
//            let body = try JSONSerialization.data(withJSONObject: requestBody, options: .fragmentsAllowed)
//            request.httpBody = body
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            URLSession.shared.dataTask(with: request) { data, _, error in
//                if let error = error {
//                    completion(.failure(error))
//                }
//
//                if data != nil {
//                    completion(.success("Register successfull"))
//                }
//            }.resume()
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    
////    func fetchUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
////        // Önce Bearer token alın
////        UserSessionService.shared.getBearerToken { result in
////            switch result {
////            case .failure(let error):
////                completion(.failure(error))
////            case .success(let token):
////                let url = URL(string: APIPath.getUserData.path)!
////                var request = URLRequest(url: url)
////                request.httpMethod = "GET"
////                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
////
////                URLSession.shared.dataTask(with: request) { data, response, error in
////                    if let error = error {
////                        completion(.failure(error))
////                        return
////                    }
////
////                    guard let data = data else {
////                        completion(.failure(NSError(domain: "NetworkError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])))
////                        return
////                    }
////
////                    do {
////                        // JSON verisini UserModel'a dönüştür
////                        // Print data string
////                        let dataString = String(data: data, encoding: .utf8)
////                        print("Data string: \(dataString)")
////                        
////                        let userModel = try JSONDecoder().decode(UserModel.self, from: data)
////                        completion(.success(userModel))
////                    } catch {
////                        completion(.failure(error))
////                    }
////                }.resume()
////            }
////        }
////    }
//
//    
//}
