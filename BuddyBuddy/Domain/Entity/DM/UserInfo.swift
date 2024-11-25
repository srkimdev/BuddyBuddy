//
//  UserInfo.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

struct UserInfo {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
}

extension UserInfo {
    func toTable() -> UserTable {
        let table = UserTable()
        table.userID = self.userID
        table.email = self.email
        table.nickname = self.nickname
        table .profileImage = self.profileImage
        return table
    }
}
