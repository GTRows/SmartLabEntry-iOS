//
//  InitialView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var userSessionService: UserSessionService
    @State private var isShowedSplashView = true

    var body: some View {
        Group {
            if isShowedSplashView {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isShowedSplashView = false
                            }
                        }
                    }
            } else {
                if userSessionService.userID != "" {
                    HomeView()
                } else {
                    AuthView()
                }
            }
        }.onAppear {
            guard let userId = userSessionService.getCurrentUser() else {
                print(Localization.userNotFound); return
            }
        }
    }
}

#Preview {
    InitialView()
}
