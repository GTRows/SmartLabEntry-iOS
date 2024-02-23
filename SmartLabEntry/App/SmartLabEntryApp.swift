
//  SmartLabEntryApp.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 24.10.2023.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SmartLabEntryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(UserSessionService.shared)
                .preferredColorScheme(.light)
        }
    }
}

