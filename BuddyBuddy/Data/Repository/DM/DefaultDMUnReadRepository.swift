//
//  DefaultDMUnReadRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

import RxSwift

final class DefaultDMUnReadRepository: DMUnReadRepositoryInterface {
    @Dependency(NetworkProtocol.self) private var service
    
    func fetchDMNoRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> RxSwift.Single<Result<DMUnRead, Error>> {
        return service.callRequest(
            router: DMRouter.dmUnRead(
                playgroundID: playgroundID,
                roomID: roomID,
                after: ""
            ),
            responseType: DMUnReadDTO.self)
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
