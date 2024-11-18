//
//  DMList.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

struct DMList {
    let roomID: String
    let createdAt: String
    let user: UserInfo
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case createdAt
        case user
    }
}

struct UserInfo {
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
