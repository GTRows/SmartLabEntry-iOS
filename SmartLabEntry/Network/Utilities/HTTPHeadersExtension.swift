//
//  HTTPHeadersExtension.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.03.2024.
//

import Alamofire
import Foundation

extension HTTPHeaders {
    mutating func addBearerToken(_ token: String) {
        add(name: "Authorization", value: "Bearer \(token)")
    }
}
