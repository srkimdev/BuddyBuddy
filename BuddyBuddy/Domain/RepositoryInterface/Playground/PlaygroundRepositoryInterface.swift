//
//  PlaygroundRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

protocol PlaygroundRepositoryInterface: AnyObject {
    func searchPlaygournd(text: String) -> Single<Result<[SearchResult], Error>>
    func fetchPlaygroundInfo() -> Single<Result<[SearchResult], Error>>
    func fetchPlaygroundList() -> Single<Result<PlaygroundList, Error>>
    func fetchCurrentPlayground() -> Single<Result<Playground, Error>>
}
