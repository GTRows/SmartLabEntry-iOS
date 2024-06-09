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
    @State var isSettingsPresented: Bool = false
    @State var isShowMoreUsers: Bool = false
    let maxMinimalUsers: Int = 5

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Divider()
                    Button {
                        viewModel.getAccessPortalList()
                    } label: {
                        Text("test")
                            .padding(.all, 10)
                            .background(.red)
                            .cornerRadius(10)
                    }
                    HStack {
                        headerView
                        Spacer()
                        settingsButtonView
                            .padding(.trailing, 30)
                    }
                    if viewModel.accessPortalList.isEmpty {
                        Text(Localization.noAccessPortal)
                            .font(.title)
                            .foregroundColor(AppTheme.lightColor)
                    } else {
                        cardsView
                        currentView
                    }
                    Spacer()
                }
                .background(
                    AppTheme.backgroundGradientView
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
                page: viewModel.currentPage,
                data: viewModel.accessPortalList,
                id: \.self
            ) { item in
                CardCellView(accessPortal: item)
            }
            .singlePagination(ratio: 0.5, sensitivity: .low)
            .onPageWillChange({ page in
                viewModel.cardChanged(index: page)
            })
            .pagingPriority(.simultaneous)
            .itemSpacing(1)
        }
        .frame(height: 250)
    }

    var currentView: some View {
        ZStack {
            Rectangle()
                .fill(AppTheme.lightColor)
                .frame(width: 350)
                .cornerRadius(20)
            VStack {
                Text("\(viewModel.accessPortalName)\n" + Localization.occupantsInLab)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.darkBlueColor)
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
                        .foregroundColor(AppTheme.darkBlueColor)
                }
            }
        }
    }

    var filteredUsers: [(offset: Int, element: CurrentUserModel)] {
        let enumeratedUsers = Array(viewModel.currentUsers.enumerated())
        return isShowMoreUsers ? enumeratedUsers : Array(enumeratedUsers.prefix(5))
    }

    var currentUsersView: some View {
        VStack {
            ForEach(filteredUsers, id: \.element.userId) { index, user in
                HStack {
                    Text("\(index + 1) - \(user.userName)")
                        .font(.system(size: 20))
                        .foregroundColor(AppTheme.darkBlueColor)
                        .lineLimit(1)
                        .padding(.leading, 45)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 250, alignment: .leading)
                    SwipeView {
                        Spacer()
                        Text("\(user.userEnterTime, formatter: DateFormatter.timeOnly)")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(AppTheme.darkBlueColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .cornerRadius(20)
                    } trailingActions: { _ in
                        Button {
                            alertService.showString(title: Localization.removeUser, message: Localization.removeUserQuestion)
                            print("Remove user pressed")
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.red)
                        }
                    }.padding(.trailing, 35)
                }

                if (viewModel.currentUsers.last?.userId != user.userId && isShowMoreUsers) || (index + 1 != maxMinimalUsers && !isShowMoreUsers) {
                    Rectangle()
                        .fill(AppTheme.darkBlueColor)
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
                .foregroundColor(AppTheme.lightColor)
        }
    }

    var headerView: some View {
        HStack {
            VStack {
                Text(Localization.hi + viewModel.name + "!")
                    .font(.custom("Comfortaa", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.lightColor)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250, alignment: .leading)
                Text(Localization.welcome)
                    .font(.custom("Comfortaa", size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(AppTheme.lightColor)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250, alignment: .leading)
            }
        }.padding(.leading, 20)
    }
}

//#Preview {
//    HomeView()
//}
