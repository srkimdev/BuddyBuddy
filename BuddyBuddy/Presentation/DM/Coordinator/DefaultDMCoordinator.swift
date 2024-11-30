//
//  DefaultDMCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

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
        let vc = DMChattingViewController(vm: DMChattingViewModel(
            coordinator: self,
            dmUseCase: DefaultDMUseCase(),
            dmListInfo: dmListInfo
        ))
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toDMChatting(userID: String) {
        // 화면 전환
    }
}
