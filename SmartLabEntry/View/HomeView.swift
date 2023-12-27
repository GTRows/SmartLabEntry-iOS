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
            headerView
                .padding(.bottom, 20)

            VStack {
                Pager(
                    page: currentPage,
                    data: viewModel.accessPortalList,
                    id: \.self
                ) { item in
                    CardCellView(accessPortal: item)
                }
                .singlePagination(ratio: 0.5, sensitivity: .high)
                .onPageWillChange({ page in
                    print("Page will change to \(page)")
                })
                .pagingPriority(.simultaneous)
                .itemSpacing(1)
            }


            //            Temp
            Button(action: {
                UserSessionService.shared.signOut()
            }, label: {
                Text("Sign Out")
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            })
            .padding()

            Button {
                print("button pressed bearer")
                UserSessionService.shared.getBearerToken { Result in
                    switch Result {
                    case let .success(token):
                        print("button bearer token: \(token)")
                    case let .failure(error):
                        print("button fialed token \(error)")
                    }
                }
            } label: {
                Text("Get bearer token")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding()

            Button {
                APIService.shared.fetchUser { Result in
                    switch Result {
                    case let .success(user):
                        print(user.toDict())
                    case let .failure(error):
                        print("error fetching user \(error)")
                    }
                }
            } label: {
                Text("fetch user")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding()

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
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
