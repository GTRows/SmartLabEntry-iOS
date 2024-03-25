//
//  SettingsPopUpView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 7.03.2024.
//

import SwiftUI

struct SettingsPopUpView: View {
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            if isShowing {
                VStack(spacing: 0) {
                    Spacer()
                    TopView
                    selectView(destination: AdminMenuView(), label: Localization.settings)
                    DividerBetweenButtons
                    selectView(destination: AdminMenuView(), label: Localization.adminPanel)
                    DividerBetweenButtons
                    selectView(destination: AdminMenuView(), label: Localization.FeedBack)
                    DividerBetweenButtons
                    selectView(destination: AdminMenuView(), label: Localization.logOut)
                    BottomVoidView
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            }
        }
    }

    var TopView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(AppTheme.coolGreyColor)
            Rectangle()
                .foregroundColor(AppTheme.slateGreyColor)
                .padding(.top, 25)
            VStack {
                Rectangle()
                    .frame(width: 100, height: 5)
                    .foregroundColor(AppTheme.slateGreyColor)
                    .cornerRadius(5)
                    .padding(.top, 10)
                Text("Name Surname Dinamik")
                    .font(.system(size: 32))
                    .foregroundColor(AppTheme.darkBlueColor)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .frame(height: 100)
    }

    func selectView<Destination: View>(destination: Destination, label: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(AppTheme.lightColor)
            VStack {
                NavigationLink(destination: destination) {
                    CustomButtonView(label: label, icon: "person.fill")
                }
            }
        }
        .frame(height: 50)
    }

    var DividerBetweenButtons: some View {
        ZStack {
            Rectangle()
                .foregroundColor(AppTheme.lightColor)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color(.gray))
                .padding(.horizontal, 25)
        }.frame(height: 20)
    }

    func CustomButtonView(label: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(AppTheme.darkBlueColor)
                .padding(.vertical, 20)
            Text(label)
                .font(.system(size: 20))
                .foregroundColor(AppTheme.darkBlueColor)
                .padding(.horizontal, 25)
        }
    }

    var BottomVoidView: some View {
        Rectangle()
            .frame(height: 50)
            .foregroundColor(AppTheme.lightColor)
    }
}

#Preview {
    SettingsPopUpView(isShowing: .constant(true))
        .previewLayout(.sizeThatFits)
        .padding()
}
