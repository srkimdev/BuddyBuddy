//
//  DMRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RxSwift

protocol DMRepositoryInterface {
    func fetchDMList(playgroundID: String) -> Single<Result<[DMList], Error>>
    
    func fetchDMHistory(
        playgroundID: String,
        roomID: String,
        cursorDate: String
    ) -> Single<Result<[DMHistory], Error>>
    
    func fetchDMNoRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> Single<Result<DMUnRead, Error>>
    
    func sendDM(
        playgroundID: String,
        roomID: String,
        message: String,
        files: [Data]
    ) -> Single<Result<DMHistoryTable, Error>>
}
