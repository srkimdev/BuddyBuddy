//
//  DMUnRead.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

struct DMUnRead {
    let roomID: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
    }
}
