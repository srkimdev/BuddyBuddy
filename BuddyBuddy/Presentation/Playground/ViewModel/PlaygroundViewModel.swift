//
//  PlaygroundViewModel.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import Foundation

import RxCocoa
import RxSwift

final class PlaygroundViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator
    private let useCase: PlaygroundUseCaseInterface
    
    init(
        coordinator: HomeCoordinator,
        useCase: PlaygroundUseCaseInterface
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
        let selectedPlayground: Observable<Workspace>
        let moreBtnTapped: Observable<String>
        let actionSheetItemTapped: Observable<ActionSheetType>
        let addBtnTapped: Observable<Void>
    }
    
    struct Output {
        let playgroundList: Driver<PlaygroundList>
        let showActionSheet: Driver<Void>
        let showExitAlert: Driver<Void>
        let showDeleteAlert: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let playgroundList = PublishRelay<PlaygroundList>()
        let playgroundID = BehaviorRelay<String>(value: "")
        let showActionSheet = PublishRelay<Void>()
        let showExitAlert = PublishRelay<Void>()
        let showDeleteAlert = PublishRelay<Void>()
        
        input.viewWillAppearTrigger
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.useCase.fetchPlaygroundList()
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    playgroundList.accept(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.selectedPlayground
            .bind(with: self) { owner, playground in
                // TODO: UserDefaultsManager playgroundID 갱신
                owner.coordinator.dismissVC()
            }
            .disposed(by: disposeBag)
        
        input.moreBtnTapped
            .bind(with: self) { owner, id in
                playgroundID.accept(id)
                showActionSheet.accept(())
            }
            .disposed(by: disposeBag)
        
        input.actionSheetItemTapped
            .bind(with: self) { owner, type in
                switch type {
                case .edit:
                    // TODO: 편집 화면 전환
                    break
                case .exit:
                    showExitAlert.accept(())
                case .changeAdmin:
                    // TODO: 관리자 변경 화면 전환
                    break
                case .delete:
                    showDeleteAlert.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        input.addBtnTapped
            .bind(with: self) { owner, _ in
                // TODO: 생성 화면 전환
            }
            .disposed(by: disposeBag)
        
        return Output(
            playgroundList: playgroundList.asDriver(onErrorJustReturn: []),
            showActionSheet: showActionSheet.asDriver(onErrorDriveWith: .empty()),
            showExitAlert: showExitAlert.asDriver(onErrorDriveWith: .empty()),
            showDeleteAlert: showDeleteAlert.asDriver(onErrorDriveWith: .empty())
        )
    }
}
