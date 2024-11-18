//
//  DMListDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

struct DMListDTO: Decodable {
    let roomID: String
    let createdAt: String
    let user: UserInfoDTO
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case createdAt
        case user
    }
}

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

extension DMListDTO {
    func toDomain() -> DMList {
        return DMList(roomID: roomID,
                      createdAt: createdAt,
                      user: user.toDomain())
    }
}

extension UserInfoDTO {
    func toDomain() -> UserInfo {
        return UserInfo(userID: userID,
                        email: email,
                        nickname: nickname,
                        profileImage: profileImage)
    }
}
