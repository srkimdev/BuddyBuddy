//
//  DefaultDMChatRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

import RxSwift

final class DefaultDMChatRepository: DMChatRepositoryInterface {
    @Dependency(NetworkProtocol.self) private var service
    
    func fetchDMChat(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> RxSwift.Single<Result<[DMChat], Error>> {
        return service.callRequest(
            router: DMRouter.dmChat(
            playgroundID: playgroundID,
            roomID: roomID,
            cursorDate: ""),
            responseType: [DMChatDTO].self
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
}
