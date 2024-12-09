//
//  DefaultDMCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

enum DMChatState {
    case fromList(DMListInfo)
    case fromProfile(String)
}

final class DefaultDMCoordinator: DMCoordinator {
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DMListViewController(vm: DMListViewModel(
            coordinator: self,
            dmUseCase: DefaultDMUseCase()
        ))
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toDMChatting(_ dmListInfo: DMListInfo) {
        let vc = DMChattingViewController(
            vm: DMChattingViewModel(
            coordinator: self,
            dmUseCase: DefaultDMUseCase(),
            dmChatState: DMChatState.fromList(dmListInfo))
        )
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toDMChatting(userID: String) {
        let vc = DMChattingViewController(
            vm: DMChattingViewModel(
            coordinator: self,
            dmUseCase: DefaultDMUseCase(),
            dmChatState: DMChatState.fromProfile(userID))
        )
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
}
