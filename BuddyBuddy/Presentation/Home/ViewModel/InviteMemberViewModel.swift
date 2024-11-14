//
//  InviteMemberViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/14/24.
//

import Foundation

import RxCocoa
import RxSwift

final class InviteMemberViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let backBtnTapped: Observable<Void>
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.backBtnTapped
            .bind(with: self) { owner, _ in
                owner.coordinator.dismissVC()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
