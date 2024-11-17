//
//  DMList.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

struct DMList {
    let room_id: String
    let createdAt: String
    let user: UserInfo
}

struct UserInfo {
    let user_id: String
    let email: String
    let nickname: String
    let profileImg: String?
}
