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
        after: Date?
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
}
