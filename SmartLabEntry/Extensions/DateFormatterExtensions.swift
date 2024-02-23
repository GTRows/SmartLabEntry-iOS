//
//  DateFormatterExtensions.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 4.02.2024.
//

import Foundation

extension DateFormatter {
    static var timeOnly: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }
}
