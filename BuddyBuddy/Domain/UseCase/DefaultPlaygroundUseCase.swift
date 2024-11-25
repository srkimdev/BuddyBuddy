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
}
