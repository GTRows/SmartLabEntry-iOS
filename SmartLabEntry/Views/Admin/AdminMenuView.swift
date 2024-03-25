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
            AdminMenuButton(.top, destination: AnyView(EmptyView()), title: Localization.doorOpenClose)
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.accessPortalOpenClose)
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.rfidCardIdentification)
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.membershipConfirmation)
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.laboratoryActivation)
            DividerBetweenButtons
            AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.feedbackControl)
            DividerBetweenButtons
            AdminMenuButton(.bottom, destination: AnyView(EmptyView()), title: Localization.memberManagement)
            Spacer()
        }
        .padding(.top)
        .background(AppTheme.backgroundGradient.edgesIgnoringSafeArea(.all))
    }

    var DividerBetweenButtons: some View {
        Rectangle()
            .frame(height: 2)
            .padding(.horizontal, 20)
            .foregroundColor(AppTheme.greyColor)
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
                        .foregroundColor(AppTheme.darkBlueColor)
                    Spacer()
                }
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
            }.padding()
                .frame(maxWidth: .infinity)
                .background(AppTheme.lightGreyColor)
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
