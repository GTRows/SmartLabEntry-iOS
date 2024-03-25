//
//  HomeViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import Foundation
import SwiftUIPager

class HomeViewModel: ObservableObject {
    @Published var name = "Name"

    @Published var accessPortalList: [AccessPortalModel] = []
    @Published var currentPage: Page = .first()
    @Published var currentUsersTemp: [CurrentUserModel] = []

    init() {
        name = "name"
        accessPortalList = [
            AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "second", isOpen: false, maxCapacity: 20, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "3lab", isOpen: true, maxCapacity: 10, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "4lab", isOpen: true, maxCapacity: 5, currentUsersId: [], logoName: "Logo_2"),
        ]
        currentUsersTemp = [
            CurrentUserModel(userId: "1", userName: "Fatih", userEnteredTime: Date()),
            CurrentUserModel(userId: "2", userName: "Ali", userEnteredTime: Date()),
            CurrentUserModel(userId: "3", userName: "Veli", userEnteredTime: Date()),
            CurrentUserModel(userId: "4", userName: "Ayşe", userEnteredTime: Date()),
            CurrentUserModel(userId: "5", userName: "Zeynep", userEnteredTime: Date()),
            CurrentUserModel(userId: "6", userName: "Mehmet", userEnteredTime: Date()),
            CurrentUserModel(userId: "7", userName: "Ahmet", userEnteredTime: Date()),
            CurrentUserModel(userId: "8", userName: "Merve", userEnteredTime: Date()),
            CurrentUserModel(userId: "9", userName: "Ece", userEnteredTime: Date()),
            CurrentUserModel(userId: "10", userName: "Ali", userEnteredTime: Date()),
        ]
    }

    // Card Changed
    func cardChanged(card: AccessPortalModel) {
        print("Card Changed: \(card.name)")
    }

    func getBearerToken() {
        UserSessionService.shared.getBearerToken { result in
            switch result {
            case let .success(token):
                print("Token: \(token)")
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }
}
