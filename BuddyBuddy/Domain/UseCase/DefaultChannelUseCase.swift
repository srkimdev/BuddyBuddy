//
//  DefaultChannelUseCase.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import RxSwift

final class DefaultChannelUseCase: ChannelUseCaseInterface {
    @Dependency(ChannelRepositoryInterface.self)
    private var repository: ChannelRepositoryInterface
    
    func fetchMyChannelList(playgroundID: String) -> Single<Result<MyChannelList, any Error>> {
        repository.fetchMyChannelList(playgroundID: playgroundID)
    }
    
    func fetchUnreadCountOfChannel(
        playgroundID: String,
        channelID: String,
        after: Date? = nil
    ) -> Single<Result<UnreadCountOfChannel, any Error>> {
        repository.fetchUnreadCountOfChannel(
            playgroundID: playgroundID,
            channelID: channelID,
            after: after
        )
    }
    
    func fetchChannelChats(
        channelID: String,
        date: String?
    ) -> Single<Result<Bool, any Error>> {
        return repository.fetchChannelChats(
            channelID: channelID,
            date: date
        )
    }
    
    func fetchSpecificChannel(channelID: String) -> Single<Result<ChannelInfo, any Error>> {
        return repository.fetchSpecificChannel(channelID: channelID)
    }
    
    func changeChannelAdmin(
        channelID: String,
        selectedUserID: String
    ) -> Single<Result<Bool, Error>> {
        return repository.changeChannelAdmin(
            channelID: channelID,
            selectedUserID: selectedUserID
        )
    }
}
