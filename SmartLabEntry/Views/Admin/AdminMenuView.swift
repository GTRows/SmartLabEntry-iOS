//
//  AdminMenuView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 21.03.2024.
//

import SwiftUI

struct AdminMenuView: View {
    var body: some View {
        VStack(spacing: 0) {
            AdminMenuButton(.top, destination: AnyView(EmptyView()), title: "Door Open/Close")
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: "Access Portal Open/Close")
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: "RFID Card Identification")
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: "Membership Confirmation")
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: "Laboratory Activation")
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: "Feedback Control")
            DividerBetweenButtons
            AdminMenuButton(.bottom, destination: AnyView(EmptyView()), title: "Member Management")
            Spacer()
        }
        .padding(.top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }

    var DividerBetweenButtons: some View {
        Rectangle()
            .frame(height: 2)
            .padding(.horizontal, 20)
            .foregroundColor(Color("Grey"))
    }
}

enum AdminMenuButtonLocation {
    case top
    case middle
    case bottom
}

struct AdminMenuButton: View {
    let location: AdminMenuButtonLocation
    let title: String
    let destination: AnyView

    init(_ location: AdminMenuButtonLocation = .middle, destination: AnyView, title: String) {
        self.location = location
        self.destination = destination
        self.title = title
    }

    var body: some View {
        VStack {
            NavigationLink(destination: destination) {
                HStack {
                    Text(self.title)
                        .font(.system(size: 20))
                        .foregroundColor(Color("DarkBlue"))
                    Spacer()
                }
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
            }.padding()
                .frame(maxWidth: .infinity)
                .background(Color("LigthGrey"))
                .clipShape(
                    .rect(
                        topLeadingRadius: location == .top ? 20 : 0,
                        bottomLeadingRadius: location == .bottom ? 20 : 0,
                        bottomTrailingRadius: location == .bottom ? 20 : 0,
                        topTrailingRadius: location == .top ? 20 : 0
                    )
                )
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AdminMenuView()
}
