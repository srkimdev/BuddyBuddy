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
}
