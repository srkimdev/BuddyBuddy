//
//  SocketRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/20/24.
//

import Foundation

import RxSwift

protocol SocketRepositoryInterface {
    func connectSocket(roomID: String)
    func disConnectSocket()
    func observeMessage() -> Observable<Void>
}
