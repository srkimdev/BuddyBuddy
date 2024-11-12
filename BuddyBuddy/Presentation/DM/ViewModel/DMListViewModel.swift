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
        let updateDMListTableView: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = BehaviorSubject<[String]>(value: [])
        
        input.viewWillAppearTrigger
            .flatMap {
                self.dmUseCase.fetchDMList(workspaceId: "")
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []))
    }
}
