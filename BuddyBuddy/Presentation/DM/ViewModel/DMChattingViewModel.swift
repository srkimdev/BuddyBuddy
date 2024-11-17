//
//  DMChattingViewModel.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DMChattingViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    private let dmUseCase: DMUseCaseInterface
    private let coordinator: DMCoordinator
    private let dmListInfo: DMListInfo
    
    init(
        dmUseCase: DMUseCaseInterface,
        coordinator: DMCoordinator,
        dmListInfo: DMListInfo
    ) {
        self.dmUseCase = dmUseCase
        self.coordinator = coordinator
        self.dmListInfo = dmListInfo
    }
    
    deinit {
        print("dmchatviewmodel deinit")
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[DMHistory]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[DMHistory]>()
        
        input.viewWillAppearTrigger
            .flatMap {
                self.dmUseCase.fetchDMHistory(
                    playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                    roomID: self.dmListInfo.roomID,
                    cursorDate: ""
                )
            }
            .bind(with: self) { _, response in
                switch response {
                case .success(let value):
                    updateDMListTableView.onNext(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []))
    }
    
}
