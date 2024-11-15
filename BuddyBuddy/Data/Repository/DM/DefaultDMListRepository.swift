//
//  DefaultDMListRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMListRepository: DMListRepositoryInterface {
    @Dependency(NetworkProtocol.self) private var service
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], any Error>> {
        return service.callRequest(
            router: DMRouter.dmList(playgroundID: playgroundID),
            responseType: [DMListDTO].self
        )
        .map { result in
            switch result {
            case .success(let dto):
                print(dto, "dto")
                return .success(dto.map { $0.toDomain() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
