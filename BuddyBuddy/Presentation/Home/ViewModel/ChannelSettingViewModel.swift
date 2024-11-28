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
    }
    struct Output {
        let channelInfo: Driver<(String, String?)>
        let channelMembers: Driver<[UserProfile]>
    }
    
    func transform(input: Input) -> Output {
        let channelInfo = PublishRelay<(String, String?)>()
        let channelMembers = PublishRelay<[UserProfile]>()
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.useCase.fetchSpecificChannel(channelID: owner.channelID)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    channelInfo.accept((value.channelName, value.description))
                    channelMembers.accept(value.channelMembers)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.blindViewTapped
            .bind(with: self) { owner, _ in
                owner.coordinator.popVC()
            }
            .disposed(by: disposeBag)
        
        return Output(
            channelInfo: channelInfo.asDriver(onErrorJustReturn: ("", "")),
            channelMembers: channelMembers.asDriver(onErrorJustReturn: [])
        )
    }
}
