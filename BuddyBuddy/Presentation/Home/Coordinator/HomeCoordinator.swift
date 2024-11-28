//
//  HomeCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

protocol HomeCoordinator: Coordinator {
    func toChannelSetting(channelID: String)
    func toChannelAdmin()
    func toInviteMember()
    func toProfile(userID: String)
    func toChannelDM()
    func toAddChannel()
    func toPlayground()
}
