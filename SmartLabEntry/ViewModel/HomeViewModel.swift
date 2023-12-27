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

    init() {
        name = "name"
        accessPortalList = [
            AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: [], logoName: "Logo_2"),
            AccessPortalModel(name: "SmartLab", isOpen: true, maxCapacity: 30, currentUsersId: [], logoName: "Logo_2"),
        ]
    }
}
