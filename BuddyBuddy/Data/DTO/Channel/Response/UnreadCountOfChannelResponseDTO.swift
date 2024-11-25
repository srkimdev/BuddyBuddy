//
//  UnreadCountOfChannelResponseDTO.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

struct UnreadCountOfChannelResponseDTO: Decodable {
    let channelID: String
    let name: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case name, count
    }
}

extension UnreadCountOfChannelResponseDTO {
    func toDomain() -> UnreadCountOfChannel {
        return UnreadCountOfChannel(
            channelID: channelID,
            name: name,
            count: count
        )
    }
}
