//
//  DefaultAuthCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

final class DefaultAuthCoordinator: AuthCoordinator {
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("DEINIT")
    }
    
    func start() {
        let vc = AuthViewController(vm: AuthViewModel(
            coordinator: self,
            userUseCase: DefaultUserUseCase()
        ))
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
}

extension DefaultAuthCoordinator {
    func changeToHome() {
        finish()
        parent?.start()
    }
}
