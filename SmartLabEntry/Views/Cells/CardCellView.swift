//
//  CardCellView.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 21.11.2023.
//

import SwiftUI

enum ActionButtonState {
    case Enter
    case Exit
    case Loading
}

struct CardCellView: View {
//    @State var isUserIn
    @State var isUserInSession: Bool = false
    @State var buttonState: ActionButtonState = .Loading
    @State var accessPortal: AccessPortalModel
    @ObservedObject var viewModel: HomeViewModel

    init(accessPortal: AccessPortalModel, viewModel: HomeViewModel) {
        self.accessPortal = accessPortal
        self.viewModel = viewModel
        buttonState = viewModel.isUserInAccessPortal ? .Exit : .Enter
    }

    var body: some View {
        ZStack {
            cardBackground
            cardContent
        }.onAppear() {
            buttonControl()
        }
    }
    
    private func buttonControl(){
        isUserInSession = viewModel.userInAccessPortal()
        buttonState = isUserInSession ? .Exit : .Enter
    }

    private var cardBackground: some View {
        Rectangle()
            .fill(AppTheme.lightColor)
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
        .padding(.bottom, 5)
    }

    private var logoImage: some View {
        Image(accessPortal.avatar)
            .resizable()
            .frame(width: 75, height: 75)
            .padding(.leading, 40)
            .padding(.bottom, 5)
    }

    private var detailsVStack: some View {
        VStack {
            HStack {
                name
                restartButton
            }
            status
            capacity
        }.padding(.top, 5)
    }

    private var restartButton: some View {
        Button(action: {
            viewModel.restartAlertViewShow = true
            print("Restart button pressed")
            print(viewModel.restartAlertViewShow)
        }) {
            Image(systemName: "lock.rotation")
                .resizable()
                .foregroundColor(AppTheme.darkBlueColor)
                .scaleEffect(x: -1, y: 1)
                .frame(width: 20, height: 20)
                .padding(.trailing, 45)
        }
    }

    private var name: some View {
        HStack {
            Text(accessPortal.name)
                .customStyle(size: 20, fontWeight: .bold)
                .padding(.leading, 10)
            Spacer()
        }
    }

    private var status: some View {
        HStack {
            statusIndicator
            Text(accessPortal.open ? Localization.open : Localization.close)
                .foregroundColor(accessPortal.open ? .green : .red)
                .customStyle()
            Spacer()
        }.padding(.bottom, 5)
    }

    private var capacity: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(AppTheme.darkBlueColor)
                .padding(.leading, 20)
            Text("\(accessPortal.currentUsers.count) / \(accessPortal.maxCapacity)")
                .customStyle()
            Spacer()
        }.padding(.bottom, 5)
    }

    private var statusIndicator: some View {
        Circle()
            .fill(accessPortal.open ? Color.green : Color.red)
            .frame(width: 10, height: 10)
            .padding(.leading, 20)
    }

    private var sessionButton: some View {
        Button(action: buttonPressed) {
            Text(viewModel.isUserInAccessPortal ? Localization.exit : Localization.enter)
                .sessionButtonStyle(isInSession: viewModel.isUserInAccessPortal)
        }
    }

    private func buttonPressed() {
        if viewModel.isUserInAccessPortal {
            viewModel.ExitAccessPortal()
        } else {
            viewModel.EnterAccessPortal()
        }
        buttonControl()
    }
}

extension Text {
    func customStyle(size: Int = 15, color: Color = AppTheme.darkBlueColor, fontWeight: Font.Weight = .medium) -> some View {
        font(.system(size: CGFloat(size)))
            .fontWeight(fontWeight)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

extension Text {
    func sessionButtonStyle(isInSession: Bool) -> some View {
        font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .frame(width: 150, height: 35)
            .background(isInSession ? Color.red : Color.green)
            .cornerRadius(20)
    }
}

#Preview {
    CardCellView(accessPortal: AccessPortalModel(id: "123", name: "SmartLab", open: true, maxCapacity: 30, currentUsers: [], avatar: "Logo_2"), viewModel: HomeViewModel())
}
