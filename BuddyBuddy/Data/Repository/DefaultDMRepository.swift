//
//  DefaultDMRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RxSwift

final class DefaultDMRepository: DMRepositoryInterface {
    @Dependency(NetworkProtocol.self) private var service
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], Error>> {
        return service.callRequest(
            router: DMRouter.dmList(playgroundID: playgroundID),
            responseType: [DMListDTO].self
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
    
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> RxSwift.Single<Result<[DMHistory], Error>> {
        return service.callRequest(
            router: DMRouter.dmHistory(
                playgroundID: playgroundID,
                roomID: roomID,
                cursorDate: cursorDate
                ),
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
