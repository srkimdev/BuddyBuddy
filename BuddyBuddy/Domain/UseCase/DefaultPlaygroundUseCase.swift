//
//  DefaultPlaygroundUseCase.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DefaultPlaygroundUseCase: PlaygroundUseCaseInterface {
    @Dependency(PlaygroundRepositoryInterface.self) private var repository
    
    func searchInPlayground(text: String) -> Single<Result<[SearchResult], Error>> {
        return repository.searchPlaygournd(text: text)
    }
    func fetchPlaygroundInfo() -> Single<Result<[SearchResult], Error>> {
        return repository.fetchPlaygroundInfo()
    }
    
    func fetchPlaygroundList() -> Single<Result<PlaygroundList, any Error>> {
        return repository.fetchPlaygroundList()
    }
    
    func fetchCurrentPlayground() -> Single<Result<Playground, any Error>> {
        return repository.fetchCurrentPlayground()
    }
}
