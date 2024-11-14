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
    
    // coodinator
    
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
