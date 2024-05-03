//
//  StringConverter.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 3.03.2024.
//

import Foundation

class StringConverter {
    static func convertToDictionary(from text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
