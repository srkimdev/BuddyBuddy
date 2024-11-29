//
//  DefaultChannelRepository.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import RxSwift

final class DefaultChannelRepository: ChannelRepositoryInterface {
    private typealias Router = ChannelRouter
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func fetchMyChannelList(playgroundID: String) -> Single<Result<MyChannelList, any Error>> {
        networkService.callRequest(
            router: Router.myChannelList(playgroundID: playgroundID),
            responseType: MyChannelListResponseDTO.self
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.map { $0.toDomain() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchUnreadCountOfChannel(
        playgroundID: String,
        channelID: String,
        after: String?
    ) -> Single<Result<UnreadCountOfChannel, any Error>> {
        networkService.callRequest(
            router: Router.unreadCount(
                playgroundID: playgroundID,
                channelID: channelID,
                after: after
            ),
            responseType: UnreadCountOfChannelResponseDTO.self
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func createChannel(request: AddChannelReqeustDTO) -> Single<Result<AddChannel, any Error>> {
        networkService.callRequest(
            router: Router.createChannel(request: request),
            responseType: AddChannelResponseDTO.self
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchChannelChats(
        channelID: String,
        date: String?
    ) -> Single<Result<Bool, any Error>> {
        let query = ChannelChatQuery(
            cursorDate: date,
            channelID: channelID,
            playgroundID: UserDefaultsManager.playgroundID
        )
        return networkService.callRequest(
            router: Router.fetchChannelChat(query: query),
            responseType: ChannelChatList.self
        )
        .map { result in
            switch result {
            case .success(_):
                return .success(true)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchSpecificChannel(channelID: String) -> Single<Result<ChannelInfo, Error>> {
        return networkService.callRequest(
            router: Router.specificChannel(
                playgroundID: UserDefaultsManager.playgroundID,
                channelID: channelID
            ),
            responseType: SpecificChannelResponseDTO.self
        )
        .map { result in
            switch result {
            case .success(let value):
                return .success(value.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    func changeChannelAdmin(
        channelID: String,
        selectedUserID: String
    ) -> Single<Result<Bool, Error>> {
        return networkService.callRequest(
            router: Router.changeChannelAdmin(
                playgroundID: UserDefaultsManager.playgroundID,
                channelID: channelID,
                ownerID: selectedUserID
            ),
            responseType: MyChannelDTO.self
        )
        .map { result in
            switch result {
            case .success(_):
                return .success(true)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func exitChannel(channelID: String) -> Single<Result<Void, Error>> {
        return networkService.callRequest(
            router: Router.exitChannel(
                playgroundID: UserDefaultsManager.playgroundID,
                channelID: channelID
            ),
            responseType: MyChannelListResponseDTO.self
        )
        .map { result in
            switch result {
            case .success(_):
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func deleteChannel(channelID: String) -> Single<Result<Void, Error>> {
        return networkService.callRequest(router: Router.deleteChannel(
            playgroundID: UserDefaultsManager.playgroundID, 
            channelID: channelID
        ))
        .map { result in
            switch result {
            case .success(_):
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
