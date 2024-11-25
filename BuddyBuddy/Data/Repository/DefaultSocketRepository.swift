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
    
    init(socketService: SocketProtocol) {
        self.socketService = socketService
    }
    
    func connectSocket(roomID: String) {
        socketService.updateURL(roomID: roomID)
        socketService.establishConnection()
    }
    
    func disConnectSocket() {
        socketService.closeConnection()
    }
    
    func observeMessage() -> Observable<DMHistoryTable> {
        return socketService.observeMessage()
    }
    
    func sendMessage(roomID: String, message: String) {
        socketService.sendMessage(to: roomID, message: message)
    }
}
