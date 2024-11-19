//
//  DefaultDMUseCase.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMUseCase: DMUseCaseInterface {
    @Dependency(DMRepositoryInterface.self) private var dmRepositoryInterface
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], Error>> {
        return dmRepositoryInterface.fetchDMList(playgroundID: playgroundID)
    }
    
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMHistory], Error>> {
        return dmRepositoryInterface.fetchDMHistory(
            playgroundID: playgroundID,
            roomID: roomID,
            cursorDate: cursorDate
        )
    }
    
    func fetchDMUnRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> Single<Result<DMUnRead, Error>> {
        return dmRepositoryInterface.fetchDMNoRead(
            playgroundID: playgroundID,
            roomID: roomID,
            after: after
        )
    }
}
