//
//  SocketService.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxSwift
import SocketIO

final class SocketService: SocketProtocol {
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    private var url = URL(string: APIKey.baseURL)
    
    private let decoder = JSONDecoder()
    private let eventSubject = PublishSubject<DMHistoryTable>()
    
    func updateURL(roomID: String) {
        guard let url else { return }
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.socket(forNamespace: "/ws-dm-\(roomID)")
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
    
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        receiveMessage()
        print("socketService")
    }
    
    func establishConnection() {
        socket.connect()
        print("connect")
    }
    
    func closeConnection() {
        socket.disconnect()
        
    }
    
    func receiveMessage() {
        socket.on("dm") { [weak self] datadict, _ in
            print("here")
            guard let self, let data = datadict[0] as? [String: Any] else { return }
            do {
                print(data, "data")
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let result = try self.decoder.decode(DMHistoryDTO.self, from: jsonData)
                let table = result.toTable()
                eventSubject.onNext(table)
                print(table)
            } catch {
                print(error)
            }
        }
    }
    
    func observeMessage() -> Observable<DMHistoryTable> {
        return eventSubject.asObservable()
    }
    
    func sendMessage(to roomID: String, message: String) {
        socket.emit(roomID, message)
    }
}
