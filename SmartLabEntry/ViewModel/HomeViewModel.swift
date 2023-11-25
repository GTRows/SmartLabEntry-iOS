//
//  HomeViewModel.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 19.11.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var userSession = UserSessionViewModel.shared
    @Published var name = "Name"

    @Published var LabNames_temp = ""
    @Published var LabDates_temp = ""

    init() {
        name = "name"
        LabNames_temp = "0"
        LabDates_temp = "1"
    }
}
