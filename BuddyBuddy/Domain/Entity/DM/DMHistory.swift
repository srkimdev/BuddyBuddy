//
//  DMHistory.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

struct DMHistory {
    let dmID: String
    let roomID: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: UserInfo
}

extension DMHistory {
    func toTable() -> DMHistoryTable {
        let table = DMHistoryTable()
        table.dmID = self.dmID
        table.roomID = self.roomID
        table.content = self.content
        table.createdAt = self.createdAt
        table.files.append(objectsIn: self.files)
        table.user = self.user.toTable()
        return table
    }
}
