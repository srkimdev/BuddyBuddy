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
    
    enum CodingKeys: String, CodingKey {
        case dmID = "dm_id"
        case roomID = "room_id"
        case content
        case createdAt
        case files
        case user
    }
}
