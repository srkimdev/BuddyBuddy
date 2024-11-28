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
    case changeChannelAdmin(userName: String)
    
    var toTitle: String {
        switch self {
        case .joinChannel:
            return "JoinChannel".localized()
        case .exitChannel:
            return "ExitChannel".localized()
        case .changeChannelAdmin(let userName):
            return "ChangeChannelAdminAlertTitle".localized(userName)
        }
    }
    
    var toMessage: String {
        switch self {
        case .joinChannel(let channelName):
            return "[\(channelName)] 채널에 참여하시겠습니까?"
        case .exitChannel:
            return ""
        case .changeChannelAdmin:
            return "ChangeChannelAdminAlertMessage".localized()
        }
    }
}
