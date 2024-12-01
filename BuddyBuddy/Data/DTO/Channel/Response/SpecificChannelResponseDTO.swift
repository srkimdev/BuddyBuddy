//
//  SpecificChannelResponseDTO.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/28/24.
//

import Foundation

struct SpecificChannelResponseDTO: Decodable {
    let channelID: String
    let channelName: String
    let description: String?
    let coverImage: String?
    let ownerID: String
    let createdAt: String
    let channelMembers: [MemberDTO]
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName = "name"
        case description
        case coverImage
        case ownerID = "owner_id"
        case createdAt
        case channelMembers
    }
}

extension SpecificChannelResponseDTO {
    func toDomain() -> ChannelInfo {
        return .init(
            channelID: channelID,
            channelName: channelName,
            description: description,
            coverImage: coverImage,
            ownerID: ownerID,
            channelMembers: channelMembers.map {
                .init(
                    userID: $0.userID,
                    email: $0.email,
                    nickname: $0.nickname,
                    profileImage: $0.profileImage
                )
            }
        )
    }
}
