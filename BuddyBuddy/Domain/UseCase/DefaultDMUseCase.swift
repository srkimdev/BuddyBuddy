//
//  DefaultDMUseCase.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMUseCase: DMUseCaseInterface {
    private let dmListRepositoryInterface: DMListRepositoryInterface
    private let dmHistoryRepositoryInterface: DMHistoryRepositoryInterface
    private let dmUnReadRepositoryInterface: DMUnReadRepositoryInterface
    
    init(
        dmListRepositoryInterface: DMListRepositoryInterface,
        dmHistoryRepositoryInterface: DMHistoryRepositoryInterface,
        dmUnReadRepositoryInterface: DMUnReadRepositoryInterface
    ) {
        self.dmListRepositoryInterface = dmListRepositoryInterface
        self.dmHistoryRepositoryInterface = dmHistoryRepositoryInterface
        self.dmUnReadRepositoryInterface = dmUnReadRepositoryInterface
    }
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], Error>> {
        return dmListRepositoryInterface.fetchDMList(playgroundID: playgroundID)
    }
    
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMHistory], Error>> {
        return dmHistoryRepositoryInterface.fetchDMHistory(
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
        return dmUnReadRepositoryInterface.fetchDMNoRead(
            playgroundID: playgroundID,
            roomID: roomID,
            after: after
        )
    }
}
