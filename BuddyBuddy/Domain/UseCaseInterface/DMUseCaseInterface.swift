//
//  DMUseCaseInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

protocol DMUseCaseInterface {
    func fetchDMList(playgroundID: String) -> Single<Result<[DMList], Error>>
    func fetchDMChat(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMHistory], Error>>
    func fetchDMUnRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> Single<Result<DMUnRead, Error>>
}
