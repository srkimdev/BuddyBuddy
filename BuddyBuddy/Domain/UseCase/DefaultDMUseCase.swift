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
        roomID: String
    ) -> Single<Result<[DMHistory], Error>> {
        return dmRepositoryInterface.fetchDMHistoryString(
            playgroundID: playgroundID,
            roomID: roomID
        )
        .flatMap { result -> Single<Result<[DMHistory], Error>> in
            self.dmRepositoryInterface.convertToDMHistoryArray(roomID: roomID)
        }
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
    
    func sendDM(
        playgroundID: String,
        roomID: String,
        message: String,
        files: [Data]
    ) -> Single<Result<[DMHistory], Error>> {
        return dmRepositoryInterface.sendDM(
            playgroundID: playgroundID,
            roomID: roomID, 
            message: message,
            files: files
        )
        .flatMap { _ -> Single<Result<[DMHistory], Error>> in
            self.dmRepositoryInterface.convertToDMHistoryArray(roomID: roomID)
        }
    }
    
    func connectSocket(roomID: String) {
        socketRepositoryInterface.connectSocket(roomID: roomID)
    }
    
    func disConnectSocket() {
        socketRepositoryInterface.disConnectSocket()
    }
    
    func observeMessage(roomID: String) -> Single<Result<[DMHistory], Error>> {
        return socketRepositoryInterface.observeMessage()
            .flatMap { _ in
                return self.dmRepositoryInterface.convertToDMHistoryArray(roomID: roomID)
            }
            .asSingle()
    }
}
