//
//  ChannelUseCaseInterface.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import RxSwift

protocol ChannelUseCaseInterface {
    func fetchMyChannelList(playgroundID: String) -> Single<Result<MyChannelList, Error>>
    func fetchUnreadCountOfChannel(
        playgroundID: String,
        channelID: String,
        after: Date?
    ) -> Single<Result<UnreadCountOfChannel, Error>>
}
