//
//  InitialView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import SwiftUI

struct InitialView: View {
    @AppStorage("uid") var userID: String = ""
    @State private var isShowedSplashView = false
    var body: some View {
        if isShowedSplashView {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isShowedSplashView = true
                        }
                    }
                }
        } else {
            if userID == "" {
                AuthView()
            } else {
                NavigationBarView()
            }
        }
    }
}

#Preview {
    InitialView()
}
