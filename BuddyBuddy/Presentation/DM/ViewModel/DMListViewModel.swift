//
//  DMViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DMListViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let dmUseCase: DMUseCaseInterface
    private let coordinator: DMCoordinator
    
    init(coordinator: DMCoordinator, dmUseCase: DMUseCaseInterface) {
        self.coordinator = coordinator
        self.dmUseCase = dmUseCase
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[DMList]>
        let viewState: Driver<DMListState>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[DMList]>()
        let viewState = PublishSubject<DMListState>()
        
        input.viewWillAppearTrigger
            .flatMap {
                self.dmUseCase.fetchDMList(plagroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4")
            }
            .bind(with: self) { _, response in
                switch response {
                case .success(let value):
                    if value.isEmpty {
                        viewState.onNext(.emptyList)
                    } else {
                        updateDMListTableView.onNext(value)
                        viewState.onNext(.chatting)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []),
            viewState: viewState.asDriver(onErrorJustReturn: .emptyList)
        )
    }
}
