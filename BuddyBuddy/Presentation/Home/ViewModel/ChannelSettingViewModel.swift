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
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    deinit {
        print("Deinit")
    }
    
    struct Input {
        let blindViewTapped: Observable<Void>
    }
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.blindViewTapped
            .bind(with: self) { owner, _ in
                owner.coordinator.popVC()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
