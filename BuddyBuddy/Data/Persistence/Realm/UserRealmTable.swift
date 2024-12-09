//
//  UserRealmTable.swift
//  BuddyBuddy
//
//  Created by 김성률 on 12/3/24.
//

import Foundation

import RealmSwift

final class UserTable: Object, Codable {
    @Persisted(primaryKey: true) var userID: String
    @Persisted var email: String
    @Persisted var nickname: String
    @Persisted var profileImage: String
    
    convenience init(
        userID: String,
        email: String,
        nickname: String,
        profileImage: String
    ) {
        self.init()
        self.userID = userID
        self.email = email
        self.nickname = nickname
        self.profileImage = profileImage
    }
}

extension UserTable {
    func toDomain() -> UserInfo {
        return UserInfo(
            userID: self.userID,
            email: self.email,
            nickname: self.nickname,
            profileImage: self.profileImage)
    }
}
