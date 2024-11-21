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
    @Dependency(SocketRepositoryInterface.self) private var socketRepositoryInterface
    
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
    
    func connectSocket(roomID: String) {
        socketRepositoryInterface.connectSocket(roomID: roomID)
    }
    
    func disConnectSocket() {
        socketRepositoryInterface.disConnectSocket()
    }
    
    func observeMessage() -> Observable<DMHistoryTable> {
        return socketRepositoryInterface.observeMessage()
    }
    
    func sendMessage(roomID: String, message: String) {
        socketRepositoryInterface.sendMessage(roomID: roomID, message: message)
    }
}
