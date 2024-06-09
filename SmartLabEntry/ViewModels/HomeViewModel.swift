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
    @Published var accessPortalName = ""
    @Published var currentUsers: [CurrentUserModel] = []
    
    
    @Published var currentPage: Page = .first()
    @Published var accessPortalList: [AccessPortalModel] = []
    

    init() {
        getAccessPortalList()
        cardChanged()
        name = "name"
        print("accessPortalList: \(accessPortalList)")
    }

    func cardChanged(index: Int = 0) {
        print("Card changed")
        print("Current page: \(currentPage.index)")
        print("current page: \(currentPage)")
        if accessPortalList.isEmpty {
            return
        }
        self.accessPortalName = accessPortalList[index].name
        self.currentUsers = accessPortalList[index].currentUsers
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

    func getAccessPortalList() {
        AccessPortalService.getAllAccessPortals { result in
            switch result {
            case let .success(accessPortals):
                self.accessPortalList = accessPortals
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }
}
