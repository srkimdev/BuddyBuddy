//
//  DefaultHomeCoordinator.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

final class DefaultHomeCoordinator: HomeCoordinator {
    @Dependency(ChannelUseCaseInterface.self)
    private var channelUseCase: ChannelUseCaseInterface
    var parent: Coordinator?
    var childs: [Coordinator] = []
    var navigationController: UINavigationController
    
    private lazy var homeVM = HomeViewModel(
        coordinator: self,
        channelUseCase: channelUseCase
    )
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController(vm: homeVM)
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toChannelSetting(channelID: String) {
        let vc = ChannelSettingViewController(vm: ChannelSettingViewModel(
            coordinator: self, 
            useCase: DefaultChannelUseCase(),
            channelID: channelID
        ))
        vc.hidesBottomBarWhenPushed = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    
    func toChannelAdmin(channelID: String) {
        let vc = ChannelAdminViewController(vm: ChangeAdminViewModel(
            coordinator: self,
            useCase: DefaultChannelUseCase(),
            channelID: channelID
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
    func toInviteMember() {
        let vc = InviteMemberViewController(vm: InviteMemberViewModel(coordinator: self))
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
   
    func toChannelDM() {
        // TODO: 채널 디엠 화면 전환
    }
    
    func toAddChannel() {
        let vm = AddChannelViewModel(
            channelUseCase: channelUseCase,
            coordinator: self
        )
        vm.delegate = homeVM
        
        let vc = AddChannelViewController(vm: vm)
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
    
    func toPlayground() {
        let coordinator = DefaultPlaygroundCoordinator(navigationController: navigationController)
        coordinator.parent = self
        childs.append(coordinator)
        coordinator.start()
    }
}
