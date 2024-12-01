//
//  DefaultSocketRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxSwift

final class DefaultSocketRepository: SocketRepositoryInterface {
    private let socketService: SocketProtocol
    private let realmRepository: RealmRepository<DMHistoryTable>
    
    init(
        socketService: SocketProtocol,
        realmRepository: RealmRepository<DMHistoryTable>
    ) {
        self.socketService = socketService
        self.realmRepository = realmRepository
    }
    
    func connectSocket(roomID: String) {
        socketService.updateURL(roomID: roomID)
        socketService.establishConnection()
    }
    
    func disConnectSocket() {
        socketService.closeConnection()
    }
    
    func observeMessage() -> Observable<DMHistoryString> {
        socketService.observeMessage()
            .map { message in
                message.toDomain()
            }
            .asObservable()
    }
}
