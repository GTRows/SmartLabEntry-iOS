//
//  AppTheme.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 25.03.2024.
//

import Foundation
import SwiftUI

struct AppTheme {
    static let blueColor = Color("Blue")
    static let darkBlueColor = Color("DarkBlue")
    static let greyColor = Color("Grey")
    static let lightGreyColor = Color("LigthGrey")
    static let lightColor = Color("Light")
    static let coolGreyColor = Color("CoolGrey")
    static let slateGreyColor = Color("SlateGrey")

    static let Logo = "Logo"
    static let Logo2 = "Logo_2"
    static let linkedinLogo = "Linkedin"
    static let instagramLogo = "Instagram"
    
    static let splashScreenDuration = 3.0

    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [AppTheme.blueColor, AppTheme.darkBlueColor]),
        startPoint: .top,
        endPoint: .bottom
    )

    static var backgroundGradientView: some View = LinearGradient(
        gradient: Gradient(colors: [AppTheme.blueColor, AppTheme.darkBlueColor]),
        startPoint: .top,
        endPoint: .bottom
    ).edgesIgnoringSafeArea(.all)
}
