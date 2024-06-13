//
//  HomeViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import Foundation
import SwiftUIPager

class HomeViewModel: ObservableObject {
    @Published var name = "name"
    @Published var accessPortalName = ""
    @Published var currentUsers: [CurrentUserModel] = []

    @Published var currentPage: Page = .first()
    @Published var accessPortalList: [AccessPortalModel] = []
    @Published var accessPortalIndex: Int = 0

    @Published var kickAlertViewShow = false
    @Published var restartAlertViewShow = false

    @Published var lastKickCurrentUser: CurrentUserModel? = nil

    @Published var isUserInAccessPortal: Bool = false

    init() {
        // async
        getAccessPortalList()
        cardChanged()
        if UserSessionService.shared.getUser().getFirstName() != "" {
            name = UserSessionService.shared.getUser().getFirstName()
        } else {
            name = "name"
            name = UserSessionService.shared.getUser().getFirstName()
        }
    }

    func userInAccessPortal() -> Bool {
        for i in accessPortalList.indices {
            for j in accessPortalList[i].currentUsers.indices {
                if accessPortalList[i].currentUsers[j].userId == UserSessionService.shared.getUser().getId() {
//                    print("User in access portal")
                    isUserInAccessPortal = true
                    return true
                }
            }
        }
//        print("User not in access portal")
        isUserInAccessPortal = false
        return false
    }

    func cardChanged(index: Int = 0) {
        print("Card changed")
        print("Current page: \(currentPage.index)")
        print("current page: \(currentPage)")
        if accessPortalList.isEmpty {
            return
        }
        accessPortalIndex = currentPage.index
        accessPortalName = accessPortalList[index].name
        currentUsers = accessPortalList[index].currentUsers
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
                self.cardChanged()
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }

    func removeUserFromAccessPortal() {
        guard let user = lastKickCurrentUser else {
            kickAlertViewShow = false
            return
        }
        let request: UserAccessPortalRequest = UserAccessPortalRequest(userId: user.userId, accessPortalId: accessPortalList[accessPortalIndex].id)
        AdminService.kickUser(userAccessPortalRequest: request) { result in
            switch result {
            case .success:
                print("User removed from access portal")
                AlertService.shared.showString(title: "User removed", message: "User removed from access portal")
                self.currentUsers.removeAll { $0.userId == user.userId }
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
        kickAlertViewShow = false
        lastKickCurrentUser = nil
    }

    func EnterAccessPortal() {
        let request: AccessPortalRequest = AccessPortalRequest(accessPortalId: accessPortalList[accessPortalIndex].id)
        AccessPortalService.enterAccessPortal(accessPortalRequest: request) { result in
            switch result {
            case .success:
                print("User entered access portal")
                AlertService.shared.showString(title: "User entered", message: "User entered access portal")
                let user = UserSessionService.shared.getUser()
                self.cardChanged(index: self.accessPortalIndex)
                self.isUserInAccessPortal = true
                self.currentUsers.append(CurrentUserModel(userId: user.getId(), userName: user.getFirstName() + user.getLastName(), userEnteredTime: Date()))
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }

    func ExitAccessPortal() {
        let request: AccessPortalRequest = AccessPortalRequest(accessPortalId: accessPortalList[accessPortalIndex].id)
        AccessPortalService.exitAccessPortal(accessPortalRequest: request) { result in
            switch result {
            case .success:
                print("User exited access portal")
                AlertService.shared.showString(title: "User exited", message: "User exited access portal")
                self.cardChanged(index: self.accessPortalIndex)
                self.isUserInAccessPortal = false
                self.currentUsers.removeAll { $0.userId == UserSessionService.shared.getUser().getId() }
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }

    func RestartAccessPortal() {
        let request = ResetPortalRequest(accessPortalId: accessPortalList[accessPortalIndex].id, isInside: true)
        AccessPortalService.resetDoor(resetPortalRequest: request) { result in
            switch result {
            case .success:
                print("Access portal restarted")
                AlertService.shared.showString(title: "Access portal restarted", message: "Access portal restarted")
            case let .failure(error):
                AlertService.shared.show(error: error)
            }
        }
    }
}
