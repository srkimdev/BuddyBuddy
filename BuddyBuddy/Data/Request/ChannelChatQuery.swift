//
//  ChannelChatQuery.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/26/24.
//

import Foundation

struct ChannelChatQuery: Encodable {
    let cursorDate: String?
    let channelID: String
    let playgroundID: String
    
    enum CodingKeys: String, CodingKey {
        case cursorDate = "cursor_date"
        case channelID
        case playgroundID = "workspaceID"
    }
}
