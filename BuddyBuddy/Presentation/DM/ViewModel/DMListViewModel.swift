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
    
    private let dmUseCase: DMUseCase
    private let coordinator: DMCoordinator
    
    init(coordinator: DMCoordinator, dmUseCase: DMUseCase) {
        self.coordinator = coordinator
        self.dmUseCase = dmUseCase
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[DMList]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[DMList]>()
        
        input.viewWillAppearTrigger
            .flatMap {
                self.dmUseCase.fetchDMList(plagroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4")
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
