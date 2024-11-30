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
    private let eventSubject = PublishSubject<DMHistoryDTO>()
    
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
            guard let self, let data = datadict[0] as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let result = try self.decoder.decode(DMHistoryDTO.self, from: jsonData)
                eventSubject.onNext(result)
            } catch {
                print(error)
            }
        }
    }
    
    func observeMessage() -> Observable<DMHistoryDTO> {
        eventSubject.asObservable()
    }
}
