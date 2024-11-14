//
//  DefaultDMUseCase.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMUseCase: DMUseCase {
    private let dmListRepositoryInterface: DMListRepositoryInterface
    
    init(dmListRepositoryInterface: DMListRepositoryInterface) {
        self.dmListRepositoryInterface = dmListRepositoryInterface
    }
    
    func fetchDMList(workspaceId: String) -> RxSwift.Single<Result<[DMList], any Error>> {
        return dmListRepositoryInterface.fetchDMList(workspaceID: workspaceId)
    }
}
