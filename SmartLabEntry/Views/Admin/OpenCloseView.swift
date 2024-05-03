//
//  OpenCloseView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.03.2024.
//

import SwiftUI

struct OpenCloseView: View {
    var openCloseState: ActiveSheet

    var body: some View {
        VStack(spacing: 0) {
            Text(openCloseState == .Door ? Localization.selectDoor : Localization.selectPortal)
                .font(.title2)
                .foregroundColor(AppTheme.darkBlueColor)
                .padding()
                .padding(.bottom)
            ForEach(0 ..< 3) { _ in
                Button(action: {
                    print("Button Clicked")
                }) {
                    HStack {
                        Text(Localization.open)
                            .font(.title)
                            .foregroundColor(AppTheme.darkBlueColor)
                    }
                }
                .frame(width: 200, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(AppTheme.lightGreyColor)
                }
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.bottom)
            }
        }.background(AppTheme.lightColor)
            .cornerRadius(20)
            .shadow(radius: 100)
            .transition(.opacity)
    }
}

#Preview {
    OpenCloseView(openCloseState: .Door)
}
