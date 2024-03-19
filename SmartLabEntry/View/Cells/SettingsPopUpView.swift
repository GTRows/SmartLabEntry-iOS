//
//  SettingsPopUpView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 7.03.2024.
//

import SwiftUI

struct SettingsPopUpView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            TopView
            SelectView
            DividerBetweenButtons
            SelectView
            DividerBetweenButtons
            SelectView
            DividerBetweenButtons
            SelectView
            BottomVoidView
        }.ignoresSafeArea()
    }

    var topRectangleColor: Color = Color(#colorLiteral(red: 0.7411764860153198, green: 0.7490196228027344, blue: 0.7843137383460999, alpha: 1))
    var topRectangleDividerColor: Color = Color(#colorLiteral(red: 0.47843137383461, green: 0.5058823823928833, blue: 0.6274510025978088, alpha: 1))

    var TopView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(topRectangleColor)
            Rectangle()
                .foregroundColor(topRectangleColor)
                .padding(.top, 25)
            VStack {
                Rectangle()
                    .frame(width: 100, height: 5)
                    .foregroundColor(topRectangleDividerColor)
                    .cornerRadius(5)
                    .padding(.top, 10)
                // Name Surname
                Text("Name Surname")
                    .font(.custom("Quicksand SemiBold", size: 32))
                    .foregroundColor(Color("DarkBlue"))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .frame(height: 100)
    }

    var SelectView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightColor"))
            VStack {
                Button(action: {
                    print("Button pressed")
                }) {
                    CustomButtonView
                }
            }
        }.frame(height: 50)
    }

    var DividerBetweenButtons: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightColor"))
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color(.gray))
                .padding(.horizontal, 25)
        }.frame(height: 20)
    }

    var CustomButtonView: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("DarkBlue"))
                .padding(.vertical, 20)
            Text("Occupants in the room")
                .font(.custom("Quicksand SemiBold", size: 20))
                .foregroundColor(Color("DarkBlue"))
                .padding(.horizontal, 25)
        }
    }

    var BottomVoidView: some View {
        Rectangle()
            .frame(height: 50)
            .foregroundColor(Color("LightColor"))
    }
}

#Preview {
    SettingsPopUpView()
}
