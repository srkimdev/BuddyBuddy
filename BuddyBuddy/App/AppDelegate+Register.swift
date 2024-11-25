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
        DIContainer.register(type: SocketProtocol.self, SocketService())
        
        DIContainer.register(
            type: DMRepositoryInterface.self,
            DefaultDMRepository()
        )
        
        DIContainer.register(
            type: SocketRepositoryInterface.self,
            DefaultSocketRepository()
        )
      
        DIContainer.register(
            type: PlaygroundRepositoryInterface.self,
            PlaygroundRepository()
        )
        
        DIContainer.register(
            type: UserRepositoryInterface.self,
            UserRepository()
        )
        
        DIContainer.register(
            type: DMUseCaseInterface.self,
            DefaultDMUseCase(
               dmListRepositoryInterface: DIContainer.resolve(
                   type: DMListRepositoryInterface.self
               ),
               dmHistoryRepositoryInterface: DIContainer.resolve(
                   type: DMHistoryRepositoryInterface.self
               ),
               dmUnReadRepositoryInterface: DIContainer.resolve(
                   type: DMUnReadRepositoryInterface.self)
            )
        )
        
        DIContainer.register(
            type: ChannelRepositoryInterface.self,
            DefaultChannelRepository(service: NetworkService())
        )
    }
}
