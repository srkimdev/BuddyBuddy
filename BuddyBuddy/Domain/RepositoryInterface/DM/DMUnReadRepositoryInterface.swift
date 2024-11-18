//
//  DMUnReadRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

import RxSwift

protocol DMUnReadRepositoryInterface {
    func fetchDMNoRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> Single<Result<DMUnRead, Error>>
}
