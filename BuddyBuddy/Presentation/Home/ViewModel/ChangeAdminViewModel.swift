//
//  ChangeAdminViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import Foundation

import RxCocoa
import RxSwift

final class ChangeAdminViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    private let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    /*
     Cell Tap - 관리자 변경 trigger -> output alert 표출 -> 화면 dismiss
     */
    struct Input {
        let backBtnTapped: Observable<Void>
    }
    
    /*
     멤버 유무
     - 무) 관리자 변경 불가 Alert
     - 유) TableView 보낼 데이터
     */
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
