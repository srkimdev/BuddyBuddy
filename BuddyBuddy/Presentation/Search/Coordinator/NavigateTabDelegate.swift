//
//  NavigateTabDelegate.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/27/24.
//

import Foundation

protocol NavigateTabDelegate: AnyObject {
    func tappedDMButton(with userID: String)
    func tappedChannelChat(with channelID: String)
}
