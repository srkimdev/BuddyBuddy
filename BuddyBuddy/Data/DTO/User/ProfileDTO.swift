//
//  ProfileDTO.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

struct ProfileDTO: Decodable {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String
    let phone: String
    let provider: String?
    let sesacCoin: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nickname
        case profileImage
        case phone
        case provider
        case sesacCoin
        case createdAt
    }
}
extension ProfileDTO {
    func toDomain() -> MyProfile {
        return .init(
            userID: userID,
            email: email,
            nickname: nickname,
            profileImage: profileImage,
            phone: phone,
            provider: provider,
            createdAt: createdAt
        )
    }
}
