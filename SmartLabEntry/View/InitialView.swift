//
//  InitialView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import SwiftUI

struct InitialView: View {
    @State private var isShowedSplashView = false
    @ObservedObject var userSession = UserSessionViewModel.shared

    var body: some View {
//        if true {
//            PagerView()
//        } else
        if isShowedSplashView {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isShowedSplashView = true
                        }
                    }
                }
        } else {
            if userSession.isLoggedIn {
                HomeView()
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    InitialView()
}
