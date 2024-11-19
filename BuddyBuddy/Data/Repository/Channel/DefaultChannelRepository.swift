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
    
    private let service: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func fetchMyChannelList(playgroundID: String) -> RxSwift.Single<Result<MyChannelList, any Error>> {
        service.callRequest(
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
    ) -> RxSwift.Single<Result<UnreadCountOfChannel, any Error>> {
        service.callRequest(
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
}
