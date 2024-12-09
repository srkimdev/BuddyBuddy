//
//  SocketService.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxCocoa
import SocketIO

final class SocketService: SocketProtocol {
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    private var url = URL(string: APIKey.baseURL)
    
    private let decoder = JSONDecoder()
    private let dmEventRelay = PublishRelay<DMHistoryDTO>()
    private let channelEventRelay = PublishRelay<ChannelHistoryResponseDTO>()
    
    func updateURL(ID: String) {
        guard let url else { return }
        manager = SocketManager(
            socketURL: url,
            config: [.log(true), .compress]
        )
        socket = manager.socket(forNamespace: "/ws-dm-\(ID)")
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
    
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        receiveDMMessage()
        receiveChannelMessage()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func receiveDMMessage() {
        socket.on("dm") { [weak self] datadict, _ in
            guard let self, let data = datadict[0] as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let result = try self.decoder.decode(
                    DMHistoryDTO.self,
                    from: jsonData
                )
                dmEventRelay.accept(result)
            } catch {
                print(error)
            }
        }
    }
    
    func receiveChannelMessage() {
        socket.on("channel") { [weak self] datadict, _ in
            guard let self, let data = datadict[0] as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let result = try self.decoder.decode(
                    ChannelHistoryResponseDTO.self,
                    from: jsonData
                )
                channelEventRelay.accept(result)
            } catch {
                print(error)
            }
        }
    }
    
    func observeDMMessage() -> PublishRelay<DMHistoryDTO> {
        return dmEventRelay
    }
    
    func observeChannelMessage() -> PublishRelay<ChannelHistoryResponseDTO> {
        return channelEventRelay
    }
}
