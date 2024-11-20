//
//  PlaygroundUseCase.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

final class PlaygroundUseCase: PlaygroundUseCaseInterface {
    @Dependency(PlaygroundRepositoryInterface.self) private var repository
    
    func searchInPlayground(text: String) -> Single<Result<PlaygroundSearch, Error>> {
        return repository.searchPlaygournd(text: text)
    }
}
