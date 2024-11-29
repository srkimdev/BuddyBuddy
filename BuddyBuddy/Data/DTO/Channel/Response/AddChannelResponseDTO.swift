//
//  AddChannelResponseDTO.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/28/24.
//

import Foundation

struct AddChannelResponseDTO: Decodable {
    let channelID, name: String
    let description: String?
    let ownerID, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case name, description
        case ownerID = "owner_id"
        case createdAt
    }
}

extension AddChannelResponseDTO {
    func toDomain() -> AddChannel {
        return AddChannel(
            channelID: channelID,
            name: name,
            description: description,
            ownerID: ownerID,
            createdAt: createdAt
        )
    }
}
