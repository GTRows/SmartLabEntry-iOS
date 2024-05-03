//
//  Constants.swift
//  SmartLabEntry
//
//  Created by Fatih Acıroğlu on 9.04.2024.
//

import Foundation

struct Constants {
    static let instagramURL: URL = URL(string: "https://www.linkedin.com/company/ktun-ai-lab/")!
    static let linkedinURL: URL = URL(string: "https://www.linkedin.com/company/ktun-ai-lab/")!
    static let ktunAiLabURL: URL = URL(string: "https://ktunailab.com/")!
    
    static let defaultUser : UserModel = UserModel(id: "0", firstName: "test", lastName: "test", email: "test@gmail.com", schoolId: "123123123", role: RoleType.UNKNOWN, isVerified: true)
}
