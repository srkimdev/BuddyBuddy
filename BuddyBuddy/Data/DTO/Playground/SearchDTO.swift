//
//  SearchDTO.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

struct SearchDTO: Decodable {
    let playgroundID: String
    let playgroundName: String
    let description: String?
    let coverImage: String
    let ownerID: String
    let createdAt: String
    let channels: [ChannelDTO]
    let playgroundMembers: [MemberDTO]
    
    enum CodingKeys: String, CodingKey {
        case playgroundID = "workspace_id"
        case playgroundName = "name"
        case description
        case coverImage
        case ownerID = "owner_id"
        case createdAt
        case channels
        case playgroundMembers = "workspaceMembers"
    }
}

extension SearchDTO {
    func toDomain() -> [SearchResult] {
        let playgroundChannel: [SearchResult] = channels.map { .init(
                state: .channel,
                id: $0.channelID,
                name: $0.channelName,
                file: $0.coverImage
            )}
        let members: [SearchResult] = playgroundMembers.map { .init(
            state: .user,
            id: $0.userID,
            name: $0.nickname,
            file: $0.profileImage
        )}
        return playgroundChannel + members
    }
}

struct ChannelDTO: Decodable {
    let channelID: String
    let channelName: String
    let coverImage: String?
    let ownerID: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName = "name"
        case coverImage
        case ownerID = "owner_id"
        case createdAt
    }
}

struct MemberDTO: Decodable {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nickname
        case profileImage
    }
}
