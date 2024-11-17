//
//  DMListDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

struct DMListDTO: Decodable {
    let room_id: String
    let createdAt: String
    let user: UserInfoDTO
}

struct UserInfoDTO: Decodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImg: String?
}

extension DMListDTO {
    func toDomain() -> DMList {
        return DMList(room_id: room_id,
                      createdAt: createdAt,
                      user: user.toDomain())
    }
}

extension UserInfoDTO {
    func toDomain() -> UserInfo {
        return UserInfo(user_id: user_id,
                        email: email,
                        nickname: nickname,
                        profileImg: profileImg)
    }
}
