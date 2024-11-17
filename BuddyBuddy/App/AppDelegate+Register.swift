//
//  AppDelegate+Register.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/8/24.
//

import Foundation

extension AppDelegate {
    /**
     의존성 주입을 위한 객체 등록 메서드
     */
    func registerDependencies() {
        DIContainer.register(type: NetworkProtocol.self, NetworkService())
        
        DIContainer.register(
            type: DMListRepositoryInterface.self,
            DefaultDMListRepository()
        )
        DIContainer.register(
            type: DMHistoryRepositoryInterface.self,
            DefaultDMHistoryRepository()
        )
        DIContainer.register(
            type: DMUnReadRepositoryInterface.self,
            DefaultDMUnReadRepository()
        )
        
        DIContainer.register(type: DMUseCaseInterface.self, 
                             DefaultDMUseCase(
                                dmListRepositoryInterface: DIContainer.resolve(type: DMListRepositoryInterface.self),
                                dmHistoryRepositoryInterface: DIContainer.resolve(type: DMHistoryRepositoryInterface.self),
                                dmUnReadRepositoryInterface: DIContainer.resolve(type: DMUnReadRepositoryInterface.self))
        )
        
    }
}
