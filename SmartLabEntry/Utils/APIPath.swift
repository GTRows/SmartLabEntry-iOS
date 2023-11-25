//
//  APIPath.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 15.11.2023.
//

import Foundation

// let usersAPI = APIPath.users.path
// let cardsAPI = APIPath.cards.path
// Diğer API yollarınız için de benzer şekilde kullanabilirsiniz.

enum APIPath {
    case users
    case getUserData
    case cards
    case cardsTest
    case doors
    case accessPortals
    case accessPortalsEntry
    case accessPortalsExit

    var path: String {
        let baseHost = "http://94.54.108.76:8080"
        let apiVersion = "api/v0.1"

        switch self {
        case .users:
            return "\(baseHost)/\(apiVersion)/users"
        case .getUserData:
            return "\(baseHost)/api/v0.2/users/me"
        case .cards:
            return "\(baseHost)/\(apiVersion)/cards"
        case .cardsTest:
            return "\(baseHost)/\(apiVersion)/cards/test"
        case .doors:
            return "\(baseHost)/\(apiVersion)/doors"
        case .accessPortals:
            return "\(baseHost)/\(apiVersion)/accessPortals"
        case .accessPortalsEntry:
            return "\(baseHost)/\(apiVersion)/accessPortals/entry"
        case .accessPortalsExit:
            return "\(baseHost)/\(apiVersion)/accessPortals/exit"
        }
    }
}
