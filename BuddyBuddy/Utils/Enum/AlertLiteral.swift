//
//  AlertLiteral.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/26/24.
//

import Foundation

enum AlertLiteral {
    case joinChannel(channelName: String)
    case exitChannel(isMyChannel: Bool)
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
        case .exitChannel(let isMyChannel):
            if isMyChannel {
                return "ExitMyChannel".localized()
            } else {
                return "JustExitChannel".localized()
            }
        case .changeChannelAdmin:
            return "ChangeChannelAdminAlertMessage".localized()
        }
    }
}
