//
//  DMChatRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

import RxSwift

protocol DMChatRepositoryInterface {
    func fetchDMChat(playgroundID: String, roomID: String, cursorDate: String) -> Single<Result<[DMChat], Error>>
}
