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
    @Persisted var files: List<String>
    @Persisted var user: UserTable?
}

final class UserTable: Object, Codable {
    @Persisted(primaryKey: true) var userID: String
    @Persisted var email: String
    @Persisted var nickname: String
    @Persisted var profileImage: String?
}

extension DMHistoryTable {
    func toChatType() -> ChatType {
        if !content.isEmpty && !files.isEmpty {
            return .TextAndImage(self)
        } else if !content.isEmpty && files.isEmpty {
            return .onlyText(self)
        } else if content.isEmpty && !files.isEmpty {
            return .onlyImage(self)
        } else {
            return .onlyText(self)
        }
    }
}
