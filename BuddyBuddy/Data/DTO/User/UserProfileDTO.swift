//
//  UserProfileDTO.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

struct UserProfileDTO: Decodable {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nickname
        case profileImage
    }
}

extension UserProfileDTO {
    func toDomain() -> UserProfile {
        return .init(
            userID: userID,
            email: email,
            nickname: nickname,
            profileImage: profileImage
        )
    }
}
