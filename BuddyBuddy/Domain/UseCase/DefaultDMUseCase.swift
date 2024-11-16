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
    private let dmChatRepositoryInterface: DMChatRepositoryInterface
    
    init(
        dmListRepositoryInterface: DMListRepositoryInterface,
         dmChatRepositoryInterface: DMChatRepositoryInterface
    ) {
        self.dmListRepositoryInterface = dmListRepositoryInterface
        self.dmChatRepositoryInterface = dmChatRepositoryInterface
    }
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], any Error>> {
        return dmListRepositoryInterface.fetchDMList(playgroundID: playgroundID)
    }
    
    func fetchDMChat(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMChat], any Error>> {
        return dmChatRepositoryInterface.fetchDMChat(
            playgroundID: playgroundID,
            roomID: roomID,
            cursorDate: cursorDate
        )
    }
}
