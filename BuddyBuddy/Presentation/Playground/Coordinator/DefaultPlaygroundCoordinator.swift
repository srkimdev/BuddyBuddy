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
    
    private lazy var vc = PlaygroundViewController(vm: vm)
    private lazy var vm = PlaygroundViewModel(
        coordinator: self,
        useCase: DefaultPlaygroundUseCase()
    )
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        vc.modalPresentationStyle = .fullScreen
        
        navigationController.present(
            vc,
            animated: true
        )
    }
    
    func presentActionSheet() {
        var actionSheet: UIAlertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        setActionSheet(&actionSheet)
        
        vc.present(
            actionSheet,
            animated: true
        )
    }
}

extension DefaultPlaygroundCoordinator {
    func setActionSheet(_ actionSheet: inout UIAlertController) {
        for type in ActionSheetType.allCases {
            var title = ""
            switch type {
            case .edit:
                title = ActionSheetTitle.edit.localized
            case .exit:
                title = ActionSheetTitle.exit.localized
            case .changeAdmin:
                title = ActionSheetTitle.changeAdmin.localized
            case .delete:
                title = ActionSheetTitle.delete.localized
            }
            
            let action = UIAlertAction(
                title: title,
                style: .default
            ) { [weak self] _ in
                guard let self else { return }
                vm.actionSheetTrigger(type)
            }
            
            actionSheet.addAction(action)
        }
    }
}
