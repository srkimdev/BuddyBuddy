//
//  HomeViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

import RxCocoa
import RxSwift

struct Playground {
    let id: String
    let title: String
}

final class HomeViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let coordinator: HomeCoordinator
    private let channelUseCase: ChannelUseCaseInterface
    private let playground: Playground
    
    init(
        coordinator: HomeCoordinator,
        channelUseCase: ChannelUseCaseInterface
    ) {
        self.coordinator = coordinator
        self.channelUseCase = channelUseCase
        self.playground = Playground(
            id: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
            title: "Ted Study"
        )
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
        let configureChannelCell: Observable<MyChannel>
        let menuBtnDidTap: Observable<Bool>
        let channelItemDidSelected: Observable<IndexPath>
        let addMemeberBtnDidTap: Observable<Void>
        let floatingBtnDidTap: Observable<Void>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let updateChannelState: Driver<[ChannelSectionModel]>
        let unreadCountList: Driver<[UnreadCountOfChannel]>
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = PublishRelay<String>()
        let updateChannelState = PublishRelay<[ChannelSectionModel]>()
        let channelList = BehaviorRelay<MyChannelList>(value: [])
        let unreadCountList = BehaviorRelay<[UnreadCountOfChannel]>(value: [])
        
        input.viewWillAppearTrigger
            .bind(with: self) { owner, _ in
                navigationTitle.accept(owner.playground.title)
            }
            .disposed(by: disposeBag)
        
        input.viewWillAppearTrigger
            .flatMap { [weak self] _ -> Single<Result<MyChannelList, any Error>> in
                // TODO: faliure 반환하며 early exit
                guard let self else { return Single.just(.success([])) }
                return channelUseCase.fetchMyChannelList(playgroundID: playground.id)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    channelList.accept(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.configureChannelCell
            .flatMap { [weak self] channel -> Single<Result<UnreadCountOfChannel, any Error>> in
                // TODO: faliure 반환하며 early exit
                guard let self else {
                    return Single.just(.success(UnreadCountOfChannel(
                        channelID: "",
                        name: "",
                        count: 0
                    )))
                }
                return channelUseCase.fetchUnreadCountOfChannel(
                    playgroundID: playground.id,
                    channelID: channel.channelID,
                    after: nil
                )
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    var list = unreadCountList.value
                    list.append(value)
                    unreadCountList.accept(list)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.menuBtnDidTap
            .bind(with: self) { owner, isFold in
                let titleItem = ChannelItem.title(isFold ? .caret : .arrow)
                let listItem = isFold ? [] : channelList.value.map { ChannelItem.channel($0) }
                let addItem = isFold ? [] : [ChannelItem.add("Add Channel")]
                
                updateChannelState.accept([.title(item: titleItem),
                                           .list(items: listItem),
                                           .add(items: addItem)])
            }
            .disposed(by: disposeBag)
        
        input.channelItemDidSelected
            .bind(with: self) { owner, indexPath in
                // TODO: 화면전환
            }
            .disposed(by: disposeBag)
        
        input.addMemeberBtnDidTap
            .bind(with: self) { owner, _ in
                // TODO: 화면전환
            }
            .disposed(by: disposeBag)
        
        input.floatingBtnDidTap
            .bind(with: self) { owner, _ in
                // TODO: 화면전환
            }
            .disposed(by: disposeBag)
        
        return Output(
            navigationTitle: navigationTitle.asDriver(onErrorJustReturn: "Buddy Buddy"),
            updateChannelState: updateChannelState.asDriver(onErrorDriveWith: .empty()),
            unreadCountList: unreadCountList.asDriver(onErrorJustReturn: [])
        )
    }
}

