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
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func searchPlaygournd(text: String) -> Single<Result<[SearchResult], Error>> {
        let query = SearchQuery(
            playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
            keyword: text
        )
        let router = PlaygroundRouter.search(query: query)
        return networkService.callRequest(router: router, responseType: SearchDTO.self)
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
