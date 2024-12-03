//
//  DefaultPlaygroundCoordinator.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/3/24.
//

import UIKit

final class DefaultPlaygroundCoordinator: PlaygroundCoordinator {
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PlaygroundViewController(
            vm: PlaygroundViewModel(
                coordinator: self,
                useCase: DefaultPlaygroundUseCase()
            )
        )
        
        navigationController.present(
            vc,
            animated: true
        )
    }
}
