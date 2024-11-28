//
//  ChannelSettingViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import Foundation

import RxCocoa
import RxSwift

final class ChannelSettingViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let coordinator: HomeCoordinator
    private let useCase: ChannelUseCaseInterface
    private let channelID: String
    
    init(
        coordinator: HomeCoordinator,
        useCase: ChannelUseCaseInterface,
        channelID: String
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.channelID = channelID
    }
    
    deinit {
        print("Deinit")
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let blindViewTapped: Observable<Void>
        let exitBtnTapped: Observable<Void>
        let changeAdminBtnTapped: Observable<Void>
    }
    struct Output {
        let channelInfo: Driver<(String, String?)>
        let channelMembers: Driver<[UserProfile]>
        let showChangeAdminBtn: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let channelInfo = PublishRelay<(String, String?)>()
        let channelMembers = PublishRelay<[UserProfile]>()
        let showChangeAdminBtn = PublishRelay<Bool>()
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.useCase.fetchSpecificChannel(channelID: owner.channelID)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    showChangeAdminBtn.accept(value.ownerID == UserDefaultsManager.userID)
                    channelInfo.accept((value.channelName, value.description))
                    channelMembers.accept(value.channelMembers)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.exitBtnTapped
            .bind(with: self) { owner, _ in
                print("나가기 버튼 탭")
            }
            .disposed(by: disposeBag)
        
        input.changeAdminBtnTapped
            .bind(with: self) { owner, _ in
                owner.coordinator.toChannelAdmin(channelID: owner.channelID)
            }
            .disposed(by: disposeBag)
        
        input.blindViewTapped
            .bind(with: self) { owner, _ in
                owner.coordinator.popVC()
            }
            .disposed(by: disposeBag)
        
        return Output(
            channelInfo: channelInfo.asDriver(onErrorJustReturn: ("", "")),
            channelMembers: channelMembers.asDriver(onErrorJustReturn: []),
            showChangeAdminBtn: showChangeAdminBtn.asDriver(onErrorJustReturn: false)
        )
    }
}
