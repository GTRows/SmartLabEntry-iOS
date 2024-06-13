//
//  HomeView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import Shimmer
import SwiftUI
import SwiftUIPager
import SwipeActions

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State var isSettingsPresented: Bool = false
    @State var isShowMoreUsers: Bool = false

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
                    if viewModel.accessPortalList.isEmpty {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.lightColor))
                            .scaleEffect(2)
                            .padding(.top, 50)
                    } else {
                        cardsView
                        currentView
                    }
                    Spacer()
                }
                .background(
                    AppTheme.backgroundGradientView
                )
                .alert(isPresented: $viewModel.restartAlertViewShow) {
                    Alert(
                        title: Text("Restart"),
                        message: Text("Are you sure you want to restart?"),
                        primaryButton: .default(Text("Yes"), action: {
                            viewModel.RestartAccessPortal() // Onaylandığında yapılacak işlem
                        }),
                        secondaryButton: .cancel(Text("No"))
                    )
                }.alert(isPresented: $viewModel.kickAlertViewShow) {
                    Alert(
                        title: Text("Kick"),
                        message: Text("Are you sure you want to kick?"),
                        primaryButton: .default(Text("Yes"), action: {
                            viewModel.removeUserFromAccessPortal()
                        }),
                        secondaryButton: .cancel(Text("No"))
                    )
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
        }.onAppear {
            viewModel.cardChanged()
        }
    }

    var cardsView: some View {
        VStack {
            Pager(
                page: viewModel.currentPage,
                data: viewModel.accessPortalList,
                id: \.self
            ) { item in
                CardCellView(accessPortal: item, viewModel: viewModel)
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
        VStack {
            Text("\(viewModel.accessPortalName)\n" + Localization.occupantsInLab)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.darkBlueColor)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            Divider()
            ScrollView {
                currentUsersView
            }
        }.background {
            Rectangle()
                .fill(AppTheme.lightColor)
                .frame(width: 350)
                .cornerRadius(20)
        }
    }

    var filteredUsers: [(offset: Int, element: CurrentUserModel)] {
        let enumeratedUsers = Array(viewModel.currentUsers.enumerated())
        return enumeratedUsers
    }

    var currentUsersView: some View {
        VStack(spacing: 5) {
            ForEach(filteredUsers, id: \.element.userId) { index, user in
                HStack {
                    Text("\(index + 1) - \(user.userName)")
                        .font(.system(size: 17))
                        .foregroundColor(AppTheme.darkBlueColor)
                        .lineLimit(1)
                        .padding(.leading, 45)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 300, alignment: .leading)
                    SwipeView {
                        Text("\(user.userEnterTime, formatter: DateFormatter.timeOnly)")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .foregroundColor(AppTheme.darkBlueColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .cornerRadius(20)
                    } trailingActions: { _ in
                        Button {
                            viewModel.lastKickCurrentUser = user
                            viewModel.kickAlertViewShow = true
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        }
                    }.padding(.trailing, 35)
                }
                if viewModel.currentUsers.last?.userId != user.userId {
                    Rectangle()
                        .fill(AppTheme.darkBlueColor)
                        .frame(width: 300, height: 1)
                }
            }
        }
    }

    var settingsButtonView: some View {
        Button(action: {
            withAnimation {
                isSettingsPresented = true
            }
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
                HStack(spacing: 0) {
                    Text(Localization.hi)
                        .font(.custom("Comfortaa", size: 35))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(AppTheme.lightColor)
                        .multilineTextAlignment(.leading)
                    if viewModel.name == "name" {
                        Text("loading...")
                            .font(.custom("Comfortaa", size: 35))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .foregroundColor(AppTheme.lightColor)
                            .multilineTextAlignment(.leading)
                            .shimmering()
                    } else {
                        Text(viewModel.name + "!")
                            .font(.custom("Comfortaa", size: 35))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .foregroundColor(AppTheme.lightColor)
                            .multilineTextAlignment(.leading)
                    }
                }
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


#Preview {
    HomeView()
}
