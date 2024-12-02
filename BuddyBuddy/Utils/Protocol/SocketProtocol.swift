//
//  SocketProtocol.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxCocoa

protocol SocketProtocol {
    func updateURL(roomID: String)
    func establishConnection()
    func closeConnection()
    func observeMessage() -> PublishRelay<DMHistoryDTO>
}
