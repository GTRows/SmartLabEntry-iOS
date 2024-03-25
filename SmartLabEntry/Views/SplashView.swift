//
//  SplashView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 26.10.2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            AuthView()
        } else {
            VStack {
                Spacer()
                Divider()
                Image(AppTheme.Logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)

                Text(Localization.splahTitle)
                    .font(.custom("Comfortaa", size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.lightColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                Spacer()
            }
            .background(
                AppTheme.backgroundGradientView
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + AppTheme.splashScreenDuration) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
