//
//  HomeView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import SwiftUI
import SwiftUIPager
import SwipeActions

struct HomeView: View {
    @StateObject var alertService = AlertService.shared
    @ObservedObject private var viewModel = HomeViewModel()
    @State var currentPage: Page = .first()
    @State var isSettingsPresented: Bool = false
    @State var isShowMoreUsers: Bool = false
    let maxMinimalUsers: Int = 5

    var body: some View {
        NavigationView {
            ZStack {
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
                if isSettingsPresented {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSettingsPresented = false
                            }
                        }
                }
                withAnimation(.easeInOut) {
                    SettingsPopUpView(isShowing: $isSettingsPresented)
                        .transition(.move(edge: .bottom))
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationBarHidden(true)
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
                Text("\(viewModel.accessPortalList[viewModel.currentPage.index].name)\nOccupants in the room")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkBlue"))
                    .multilineTextAlignment(.center)
                    .padding()

                if isShowMoreUsers {
                    ScrollView {
                        currentUsersView
                    }
                } else {
                    currentUsersView
                }

                Spacer()
                Button {
                    isShowMoreUsers.toggle()
                } label: {
                    Image(systemName: isShowMoreUsers ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 30, height: 20)
                        .foregroundColor(Color("DarkBlue"))
                }
            }
        }
    }

    var filteredUsers: [(offset: Int, element: CurrentUserModel)] {
        let enumeratedUsers = Array(viewModel.currentUsersTemp.enumerated())
        return isShowMoreUsers ? enumeratedUsers : Array(enumeratedUsers.prefix(5))
    }

    var currentUsersView: some View {
        VStack {
            ForEach(filteredUsers, id: \.element.userId) { index, user in
                HStack {
                    Text("\(index + 1) - \(user.userName)")
                        .font(.custom("Comfortaa", size: 20))
                        .foregroundColor(Color("DarkBlue"))
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .padding(.horizontal)
                        .cornerRadius(20)
                        .padding(.horizontal, 35)
                    SwipeView {
                        Spacer()
                        Text("\(user.userEnteredTime, formatter: DateFormatter.timeOnly)")
                            .font(.custom("Comfortaa", size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color("DarkBlue"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .cornerRadius(20)
                    } trailingActions: { _ in
                        Button {
                            alertService.showString(title: "Remove user", message: "Remove user button pressed")
                            print("Remove user")
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.red)
                        }
                    }.padding(.horizontal, 35)
                }

                if (viewModel.currentUsersTemp.last?.userId != user.userId && isShowMoreUsers) || (index + 1 != maxMinimalUsers && !isShowMoreUsers) {
                    Rectangle()
                        .fill(Color("DarkBlue"))
                        .frame(width: 300, height: 1)
                }
            }
        }
    }

    var settingsButtonView: some View {
        // logout button
        Button(action: {
            withAnimation {
                isSettingsPresented = true
            }
//            alertService.showString(title: "Logout", message: "Logout button pressded")
//            print("Logout")
//            UserSessionService.shared.signOut()
        }) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color("LightColor"))
        }
    }

    var headerView: some View {
        HStack {
            VStack {
                Text("Hi, \(viewModel.name)!")
                    .font(.custom("Comfortaa", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(Color("LightColor"))
                    .multilineTextAlignment(.leading)
                    .frame(width: 250, alignment: .leading)
                Text("Welcome to AI Lab!")
                    .font(.custom("Comfortaa", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(Color("LightColor"))
                    .multilineTextAlignment(.leading)
                    .frame(width: 250, alignment: .leading)
            }
        }.padding(.leading, 20)
    }
}

#Preview {
    HomeView()
}
