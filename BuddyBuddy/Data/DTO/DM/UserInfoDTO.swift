//
//  UserInfoDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

struct UserInfoDTO: Decodable {
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

extension UserInfoDTO {
    func toDomain() -> UserInfoString {
        return UserInfoString(
            userID: userID,
            email: email,
            nickname: nickname,
            profileImage: profileImage
        )
    }
}
