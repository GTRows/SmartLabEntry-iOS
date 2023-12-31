//
//  CardCellView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 21.11.2023.
//

import SwiftUI

struct CardCellView: View {
    @State var isUserInSession: Bool = false
    @State var accessPortal: AccessPortalModel

    init(accessPortal: AccessPortalModel) {
        self.accessPortal = accessPortal
    }

    var body: some View {
        ZStack {
            cardBackground
            cardContent
        }
    }

    private var cardBackground: some View {
        Rectangle()
            .fill(Color("LightColor"))
            .frame(width: 350, height: 200)
            .cornerRadius(20)
    }

    private var cardContent: some View {
        VStack {
            logoAndDetails
            sessionButton
        }
    }

    private var logoAndDetails: some View {
        HStack {
            logoImage
            detailsVStack
        }
    }

    private var logoImage: some View {
        Image(accessPortal.logoName)
            .resizable()
            .frame(width: 100, height: 100)
            .padding(.leading, 40)
    }

    private var detailsVStack: some View {
        VStack {
            name
            status
            capacity
        }
    }

    private var name: some View {
        HStack {
            Text(accessPortal.name)
                .customStyle(size: 30, fontWeight: .bold)
            Spacer()
        }
    }

    private var status: some View {
        HStack {
            statusIndicator
            Text(accessPortal.isOpen ? "Online" : "Offline")
                .customStyle()
            Spacer()
        }
    }

    private var capacity: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(Color("DarkBlue"))
                .padding(.leading, 20)
            Text("\(accessPortal.currentUsersId.count)/\(accessPortal.maxCapacity)")
                .customStyle()
            Spacer()
        }
    }

    private var statusIndicator: some View {
        Circle()
            .fill(accessPortal.isOpen ? Color.green : Color.red)
            .frame(width: 10, height: 10)
            .padding(.leading, 20)
    }

    private var sessionButton: some View {
        Button(action: buttonPressed) {
            Text(isUserInSession ? "Exit" : "Join")
                .sessionButtonStyle(isInSession: isUserInSession)
        }
    }

    private func buttonPressed() {
        // Burada butonun işlevselliği yer alacak.
    }
}

extension Text {
    func customStyle(size: Int = 15, color: Color = Color("DarkBlue"), fontWeight: Font.Weight = .medium) -> some View {
        font(.custom("Comfortaa", size: CGFloat(size)))
            .fontWeight(fontWeight)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

extension Text {
    func sessionButtonStyle(isInSession: Bool) -> some View {
        font(.custom("Comfortaa", size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .frame(width: 200, height: 50)
            .background(isInSession ? Color.red : Color.green)
            .cornerRadius(20)
    }
}

 #Preview {
    CardCellView(accessPortal: AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: ["asd","123","1233"], logoName: "star"))
 }
