//
//  AdminMenuView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 21.03.2024.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case Door
    case AccessPortal
    case none

    var id: Int {
        hashValue
    }
}

struct AdminMenuView: View {
    @State public var activeSheet: ActiveSheet = .none

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                AdminMenuButton(.top, destination: AnyView(EmptyView()), title: Localization.doorOpenClose).onTapGesture {
                    withAnimation(.easeInOut) {
                        self.activeSheet = .Door
                    }
                }
                DividerBetweenButtons
                AdminMenuButton(destination: AnyView(EmptyView()), title: Localization.accessPortalOpenClose).onTapGesture {
                    withAnimation(.easeInOut) {
                        self.activeSheet = .AccessPortal
                    }
                }
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
            if activeSheet != .none {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            activeSheet = .none
                        }
                    }
                withAnimation(.easeInOut) {
                    OpenCloseView(openCloseState: activeSheet)
                        .transition(.opacity)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
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
