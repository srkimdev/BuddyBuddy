//
//  ToastMessage.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/29/24.
//

import Foundation

enum ToastMessage {
    case createChannel
    
    var localized: String {
        switch self {
        case .createChannel:
            return "ChannelCreateSuccess".localized()
        }
    }
}
