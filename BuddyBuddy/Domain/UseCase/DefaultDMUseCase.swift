//
//  DefaultDMUseCase.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift

final class DefaultDMUseCase: DMUseCaseInterface {
    private let dmListRepositoryInterface: DMListRepositoryInterface
    
    init(dmListRepositoryInterface: DMListRepositoryInterface) {
        self.dmListRepositoryInterface = dmListRepositoryInterface
    }
    
    func fetchDMList(plagroundID: String) -> RxSwift.Single<Result<[DMList], any Error>> {
        return dmListRepositoryInterface.fetchDMList(playgroundID: plagroundID)
    }
}
