//
//  NavigationView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 26.10.2023.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        VStack {
            Spacer()
            Divider()
            Button {
                UserSessionViewModel.shared.signOut()
            } label: {
                Text("Logout")
                    .font(.custom("Comfortaa", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color("LightColor"))
                    .frame(width: 320, height: 60)
                    .background(.blue)
                    .cornerRadius(15)
            }
            Spacer()
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        
//        ZStack {
//            SplashView()
//            VStack {
//                Spacer()
//                navigationBarView
//            }
//        }
        
    }

    var navigationBarView: some View {
        HStack {
            navigationButtonView(imageName: "person", text: "Giriş Yap")
            navigationButtonView(imageName: "person.2", text: "Kayıt Ol")
        }
        .frame(width: 350, height: 70)
        .background(Color("LightColor"))
        .cornerRadius(20)
    }

    func navigationButtonView(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.bottom, 20)

            Text(text)
                .font(.custom("Comfortaa", size: 25))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkBlue"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    NavigationBarView()
}
