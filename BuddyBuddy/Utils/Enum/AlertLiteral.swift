//
//  AlertLiteral.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/26/24.
//

import Foundation

enum AlertLiteral {
    case joinChannel(channelName: String)
    case exitChannel
    case deleteChannel
    case changeChannelAdmin
    case selectChannelAdmin
    
    var toText: String {
        switch self {
        case .joinChannel(let channelName):
            return "[\(channelName)] 채널에 참여하시겠습니까?"
        case .exitChannel:
            return ""
        case .deleteChannel:
            return ""
        case .changeChannelAdmin:
            return ""
        case .selectChannelAdmin:
            return ""
        }
    }
}
