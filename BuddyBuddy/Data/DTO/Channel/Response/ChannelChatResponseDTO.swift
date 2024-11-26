//
//  ChannelChatResponseDTO.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/26/24.
//

import Foundation

typealias ChannelChatList = [ChannelChatResponseDTO]

struct ChannelChatResponseDTO: Decodable {
    let channelID: String
    let channelName: String
    let chatID: String
    let content: String
    let createdAt: String
    let files: [String]
    let user: UserProfileDTO
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case channelName
        case chatID = "chat_id"
        case content
        case createdAt
        case files
        case user
    }
}
