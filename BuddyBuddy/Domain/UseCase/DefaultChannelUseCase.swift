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
    @Dependency(SocketRepositoryInterface.self)
    private var socketRepositoryInterface
    
    func fetchMyChannelList(playgroundID: String) -> Single<Result<MyChannelList, any Error>> {
        repository.fetchMyChannelList(playgroundID: playgroundID)
    }
    
    func fetchUnreadCountOfChannel(
        playgroundID: String,
        channelID: String,
        after: String? = nil
    ) -> Single<Result<UnreadCountOfChannel, any Error>> {
        repository.fetchUnreadCountOfChannel(
            playgroundID: playgroundID,
            channelID: channelID,
            after: after
        )
    }
    
    func createChannel(request: AddChannelReqeustDTO) -> Single<Result<AddChannel, any Error>> {
        repository.createChannel(request: request)
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
    
    func deleteChannel(channelID: String) -> Single<Result<Void, any Error>> {
        return repository.deleteChannel(channelID: channelID)
    }
    func exitChannel(channelID: String) -> Single<Result<Void, any Error>> {
        return repository.exitChannel(channelID: channelID)
    }
    
    func fetchChannelHistory(
        playgroundID: String,
        channelID: String
    ) -> Single<Result<[ChannelHistory], Error>> {
        return repository.fetchChannelHistoryString(
            playgroundID: playgroundID,
            channelID: channelID
        )
        .flatMap { response -> Single<Result<[ChannelHistory], Error>> in
            switch response {
            case .success(let value):
                return self.repository.convertArrayToChannelHistory(
                    channelID: channelID,
                    channelHistoryStringArray: value)
                .flatMap { _ in
                    self.repository.fetchChannelHistoryTable(channelID: channelID)
                }
            case .failure(let error):
                return Single.just(.failure(error))
            }
        }
    }
    
    func sendChannel(
        playgroundID: String,
        channelID: String,
        message: String,
        files: [Data]
    ) -> Single<Result<[ChannelHistory], Error>> {
        return repository.sendChannelChat(
            playgroundID: playgroundID,
            channelID: channelID,
            message: message,
            files: files
        )
        .flatMap { response -> Single<Result<[ChannelHistory], Error>> in
            switch response {
            case .success(let value):
                return self.repository.convertObjectToChannelHistory(
                    channelID: channelID,
                    channelHistoryString: value
                )
                .flatMap { _ in
                    self.repository.fetchChannelHistoryTable(channelID: channelID)
                }
            case .failure(let error):
                return Single.just(.failure(error))
            }
        }
    }
    
    func connectSocket(channelID: String) {
        socketRepositoryInterface.connectSocket(ID: channelID)
    }
    
    func disConnectSocket() {
        socketRepositoryInterface.disConnectSocket()
    }

    func observeMessage(channelID: String) -> Observable<Result<[ChannelHistory], Error>> {
        return self.socketRepositoryInterface.observeChannelMessage()
            .flatMap { channelHistoryString in
                self.repository.convertObjectToChannelHistory(
                    channelID: channelID,
                    channelHistoryString: channelHistoryString)
            }
            .flatMap { _ in
                self.repository.fetchChannelHistoryTable(channelID: channelID)
            }
            .asObservable()
    }
}
