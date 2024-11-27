//
//  DefaultSearchCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

final class DefaultSearchCoordinator: SearchCoordinator, NavigateTabDelegate {
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = SearchViewModel(
            coordinator: self,
            playgroundUseCase: DefaultPlaygroundUseCase(),
            channelUseCase: DefaultChannelUseCase()
        )
        vm.delegate = self
        let vc = SearchViewController(vm: vm)
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toProfile(userID: String) {
        let vm = ProfileViewModel(
            coordinator: self,
            userUseCase: DefaultUserUseCase(),
            userID: userID
        )
        vm.delegate = self
        let vc = ProfileViewController(vm: vm)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(
            vc,
            animated: true
        )
    }
    
    func tappedDMButton(with userID: String) {
        dismissVC()
        parent?.selectTab(.dm)
        
        if let tabCoordi = parent as? TabBarCoordinator {
            tabCoordi.navigateToDMChatRoom(chatID: userID)
        }
    }
    
    func tappedChannelChat(with channelID: String) {
        parent?.selectTab(.home)
        
        if let tabCoordi = parent as? TabBarCoordinator {
            tabCoordi.navigateToChannelChatRoom(channelID: channelID)
        }
    }
}
