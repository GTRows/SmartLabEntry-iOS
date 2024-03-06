//
//  Extansions.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 6.03.2024.
//

import Foundation

extension String {
    func toData() -> Data? {
        return self.data(using: .utf8)
    }
}

