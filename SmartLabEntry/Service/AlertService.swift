//
//  AlertService.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 14.11.2023.
//

import Foundation
import SwiftUI

final class AlertService: ObservableObject {
    static let shared = AlertService()

    @Published var isPresenting: Bool = false
    @Published var alert: Alert = Alert(title: Text(""))

    private init() {}

    func show(error: Error) {
        print(error.localizedDescription)
        alert = Alert(title: Text("Error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("OK")) {
                          self.isPresenting = false
                      })
        isPresenting = true
    }

    func showString(title: String, message: String) {
        print("Alert Service: \(title) - \(message)")
        alert = Alert(title: Text(title),
                      message: Text(message),
                      dismissButton: .default(Text("OK")) {
                          self.isPresenting = false
                      })
        isPresenting = true
    }
}


