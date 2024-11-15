//
//  DefaultDMListRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMListRepository: DMListRepositoryInterface {
    func fetchDMList(workspaceID: String) -> RxSwift.Single<Result<[DMList], any Error>> {
        return NetworkService.shared.callRequest(
            router: APIRouter.dmList(workspaceID: workspaceID),
            responseType: [DMListDTO].self
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.map { $0.toDomain() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
