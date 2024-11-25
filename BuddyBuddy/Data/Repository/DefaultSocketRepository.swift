//
//  DefaultSocketRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxSwift

final class DefaultSocketRepository: SocketRepositoryInterface {
    @Dependency(SocketProtocol.self) private var socket
    
    func connectSocket(roomID: String) {
        socket.updateURL(roomID: roomID)
        socket.establishConnection()
    }
    
    func disConnectSocket() {
        socket.closeConnection()
    }
    
    func observeMessage() -> Observable<DMHistoryTable> {
        return socket.observeMessage()
    }
    
    func sendMessage(roomID: String, message: String) {
        socket.sendMessage(to: roomID, message: message)
    }
}
