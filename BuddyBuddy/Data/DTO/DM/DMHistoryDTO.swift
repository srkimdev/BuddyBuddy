//
//  DMHistoryDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

struct DMHistoryDTO: Decodable {
    let dm_id: String
    let room_id: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: UserInfoDTO
}

extension DMHistoryDTO {
    func toDomain() -> DMHistory {
        return DMHistory(dm_id: dm_id,
                      room_id: room_id, 
                      content: content,
                      createdAt: createdAt,
                      files: files,
                      user: user.toDomain())
    }
}
