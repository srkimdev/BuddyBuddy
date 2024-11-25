//
//  DefaultSearchCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

final class DefaultSearchCoordinator: SearchCoordinator {
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchViewController(vm: SearchViewModel(
            coordinator: self,
            playgroundUseCase: DefaultPlaygroundUseCase()
        ))
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toProfile(userID: String) {
        let vc = ProfileViewController(vm: ProfileViewModel(
                coordinator: self,
                userUseCase: DefaultUserUseCase(),
                userID: userID
            ))
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
}
