//
//  MyChannelListResponseDTO.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

typealias MyChannelListResponseDTO = [MyChannelDTO]

struct MyChannelDTO: Decodable {
    let channelID, name: String
    let description: String?
    let coverImage: String?
    let ownerID, createdAt: String

    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case name, description, coverImage
        case ownerID = "owner_id"
        case createdAt
    }
}

extension MyChannelDTO {
    func toDomain() -> MyChannel {
        return MyChannel(
            channelID: channelID,
            name: name,
            description: description,
            coverImage: coverImage,
            ownerID: ownerID,
            createdAt: createdAt
        )
    }
}
