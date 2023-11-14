//
//  logoutViewTemp.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 5.11.2023.
//

import FirebaseAuth
import SwiftUI

struct logoutViewTemp: View {
    @AppStorage("uid") var userID: String = ""

    var body: some View {
        VStack {
            Text("test")

            Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    withAnimation {
                        userID = ""
                    }
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                    AlertService.shared.show(error: signOutError)
                }
            }) {
                // sign out view
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Spacer()
                        Text("Sign Out")
                        Spacer()
                    }
                    .frame(maxWidth: 250)
                    .foregroundColor(.black)
                    .padding()
                }.frame(width: 250, height: 50)
            }
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    logoutViewTemp()
}
