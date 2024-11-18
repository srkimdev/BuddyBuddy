//
//  DMUnReadDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

struct DMUnReadDTO: Decodable {
    let roomID: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case count
    }
}

extension DMUnReadDTO {
    func toDomain() -> DMUnRead {
        return .init(
            roomID: roomID,
            count: count
        )
    }
}
