//
//  SplashView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 26.10.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
            Divider()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.bottom,20)
            
            Text("Yapay Zeka ve\nVeri Bilimi  Laboratuvarı")
                .font(.custom("Comfortaa", size: 25))
                .fontWeight(.bold)
                .foregroundColor(Color("LightColor"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}


#Preview {
    SplashView()
}
