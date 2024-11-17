//
//  DefaultDMHistoryRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

import RxSwift

final class DefaultDMHistoryRepository: DMHistoryRepositoryInterface {
    @Dependency(NetworkProtocol.self) private var service
    
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> RxSwift.Single<Result<[DMHistory], Error>> {
        return service.callRequest(
            router: DMRouter.dmHistory(
            playgroundID: playgroundID,
            roomID: roomID,
            cursorDate: ""),
            responseType: [DMHistoryDTO].self
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
