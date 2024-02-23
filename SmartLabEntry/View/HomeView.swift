//
//  HomeView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import SwiftUI
import SwiftUIPager

struct HomeView: View {
    @StateObject var alertService = AlertService.shared
    @ObservedObject private var viewModel = HomeViewModel()
    @State var currentPage: Page = .first()

    var body: some View {
        VStack {
            Divider()
            HStack {
                headerView
                Spacer()
                settingsButtonView
                    .padding(.trailing, 30)
            }
            cardsView
            currentView
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("DarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .alert(isPresented: $alertService.isPresenting) {
            alertService.alert
        }
    }

    var cardsView: some View {
        VStack {
            Pager(
                page: currentPage,
                data: viewModel.accessPortalList,
                id: \.self
            ) { item in
                CardCellView(accessPortal: item)
            }
            .singlePagination(ratio: 0.5, sensitivity: .low)
            .onPageWillChange({ page in
                print("Page will change to \(page)")
            })
            .pagingPriority(.simultaneous)
            .itemSpacing(1)
        }
        .frame(height: 250)
    }

    var currentView: some View {
        ZStack {
            Rectangle()
                .fill(Color("LightColor"))
                .frame(width: 350)
                .cornerRadius(20)
            VStack {
                Text("Occupants in the room")
                    .font(.custom("Comfortaa", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkBlue"))
                    .multilineTextAlignment(.center)
                    .padding()

                // Use ForEach instead of for loop
                ForEach(viewModel.currentUsersTemp, id: \.userId) { user in
                    HStack {
                        Text(user.userName)
                            .font(.custom("Comfortaa", size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DarkBlue"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                        Text("\(user.userEnteredTime, formatter: DateFormatter.timeOnly)")
                            .font(.custom("Comfortaa", size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DarkBlue"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .background(Color("LightColor"))
                    .cornerRadius(20)
                    .padding(.horizontal, 35)
                }

                Spacer()
            }
        }
    }

    var settingsButtonView: some View {
        // logout button
        Button(action: {
            alertService.showString(title: "Logout", message: "Logout button pressded")
            print("Logout")
            UserSessionService.shared.signOut()
        }) {
            Image(systemName: "person.crop.circle.badge.xmark")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color("LightColor"))
        }
    }

    var headerView: some View {
        HStack {
            VStack {
                Text("Hi, \(viewModel.name)!")
                    .font(.custom("Comfortaa", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color("LightColor"))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
                Text("Welcome to AI Lab!")
                    .font(.custom("Comfortaa", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(Color("LightColor"))
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    HomeView()
}
