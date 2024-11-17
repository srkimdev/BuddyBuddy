//
//  DMHistoryRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/16/24.
//

import Foundation

import RxSwift

protocol DMHistoryRepositoryInterface {
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMHistory], Error>>
}
