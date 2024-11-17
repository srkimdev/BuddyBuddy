//
//  DMHistory.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

struct DMHistory {
    let dm_id: String
    let room_id: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: UserInfo
}
