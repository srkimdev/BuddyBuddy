//
//  DefaultDMRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RxSwift

final class DefaultDMRepository: DMRepositoryInterface {
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], Error>> {
        return networkService.callRequest(
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
        return networkService.callRequest(
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
        return networkService.callRequest(
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
    
    func sendDM(
        playgroundID: String,
        roomID: String,
        message: String
    ) -> Single<Result<DMHistoryTable, Error>> {
        return networkService.callMultiPart(
            router: DMRouter.dmSend(
                playgroundID: playgroundID,
                roomID: roomID,
                message: message
            ),
            responseType: DMHistoryDTO.self,
            content: message
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.toTable())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
