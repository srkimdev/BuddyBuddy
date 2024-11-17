//
//  DMUnReadDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

struct DMUnReadDTO: Decodable {
    let room_id: String
    let count: Int
}

extension DMUnReadDTO {
    func toDomain() -> DMUnRead {
        return .init(
            room_id: room_id,
            count: count
        )
    }
}
