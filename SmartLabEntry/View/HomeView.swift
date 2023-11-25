//
//  HomeView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var alertService = AlertService.shared
    @ObservedObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            Divider()
            headerView
                .padding(.bottom, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 100) { _ in
                        HStack {
                            Text("123")
                                .foregroundColor(.white)
                        }
                        .frame(width: 250, height: 120, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                    }
                    .padding(.leading, 10)
                }
            }

//            CardCellView(logoName: "star", title: "SmartLab \(item)", isAccessPortalOnline: false, isUserInSession: false, currentCapacity: 20, maxCapacity: 30)

            //            Temp
            Button(action: {
                UserSessionViewModel.shared.signOut()
            }, label: {
                Text("Sign Out")
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            })
            .padding()

            Button {
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
