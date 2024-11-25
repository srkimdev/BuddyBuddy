//
//  DefaultPlaygroundRepository.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DefaultPlaygroundRepository: PlaygroundRepositoryInterface {
    typealias Router = PlaygroundRouter
    
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func searchPlaygournd(text: String) -> Single<Result<[SearchResult], Error>> {
        let query = SearchQuery(
            playgroundID: UserDefaultsManager.playgroundID,
            keyword: text
        )
        let router = Router.search(query: query)
        return networkService.callRequest(
            router: router,
            responseType: SearchDTO.self
        )
        .map { result in
            switch result {
            case .success(let value):
                return .success(value.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchPlaygroundInfo() -> Single<Result<[SearchResult], Error>> {
        return networkService.callRequest(
            router: Router.specificPlaygroundInfo,
            responseType: SearchDTO.self
        )
        .map { result in
            switch result {
            case .success(let value):
                return .success(value.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
