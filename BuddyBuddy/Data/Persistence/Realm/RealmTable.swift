//
//  ChattingTable.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RealmSwift

final class DMHistoryTable: Object {
    @Persisted(primaryKey: true) var dmID: String
    @Persisted var roomID: String
    @Persisted var content: String
    @Persisted var createdAt: String
    @Persisted var files: List<Data> = List()
    @Persisted var user: UserTable?
    
    convenience init(
        dmID: String,
        roomID: String,
        content: String,
        createdAt: String,
        files: List<Data>,
        user: UserTable
    ) {
        self.init()
        self.dmID = dmID
        self.roomID = roomID
        self.content = content
        self.createdAt = createdAt
        self.files = files
        self.user = user
    }
}

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

extension DMHistoryTable {
    func toDomain() -> DMHistory {
        return DMHistory(
            dmID: self.dmID,
            roomID: self.roomID,
            content: self.content,
            createdAt: self.createdAt,
            files: Array(self.files),
            user: user?.toDomain() ?? UserInfo(
                userID: "",
                email: "",
                nickname: "",
                profileImage: ""
            )
        )
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
