//
//  PlaygroundUseCaseInterface.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxSwift

protocol PlaygroundUseCaseInterface: AnyObject {
    func fetchPlaygroundInfoWithImage() -> Single<Result<[SearchResultWithImage], Error>>
    func searchInPlaygroundWithImage(text: String) -> Single<Result<[SearchResultWithImage], Error>>
    func fetchPlaygroundList() -> Single<Result<PlaygroundList, Error>>
    func fetchCurrentPlayground() -> Single<Result<Playground, Error>>
}
