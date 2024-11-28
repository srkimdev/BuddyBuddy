//
//  ChannelRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import RxSwift

protocol ChannelRepositoryInterface {
    func fetchMyChannelList(playgroundID: String) -> Single<Result<MyChannelList, Error>>
    func fetchUnreadCountOfChannel(
        playgroundID: String,
        channelID: String,
        after: Date?
    ) -> Single<Result<UnreadCountOfChannel, Error>>
    func fetchChannelChats(
        channelID: String,
        date: String?
    ) -> Single<Result<Bool, any Error>>
    func fetchSpecificChannel(channelID: String) -> Single<Result<ChannelInfo, Error>>
    func changeChannelAdmin(
        channelID: String,
        selectedUserID: String
    ) -> Single<Result<Bool, Error>>
    func exitChannel(channelID: String) -> Single<Result<Void, Error>>
    func deleteChannel(channelID: String) -> Single<Result<Void, Error>>
}
