//
//  DMViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DMViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let coordinator: DMCoordinator
    
    init(coordinator: DMCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = BehaviorSubject<[String]>(value: [])
        
        input.viewWillAppearTrigger
            .subscribe(with: self) { _ in
                updateDMListTableView.onNext(["1", "2", "3"])
            }
            .disposed(by: disposeBag)
        
        return Output(updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []))
    }
}
