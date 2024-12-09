//
//  SocketProtocol.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxCocoa

protocol SocketProtocol {
    func updateURL(ID: String)
    func establishConnection()
    func closeConnection()
    func observeDMMessage() -> PublishRelay<DMHistoryDTO>
    func observeChannelMessage() -> PublishRelay<ChannelHistoryResponseDTO>
}
