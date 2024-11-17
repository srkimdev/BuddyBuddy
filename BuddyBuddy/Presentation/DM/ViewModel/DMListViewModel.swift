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
    
    struct DMListInfo {
        let profileImg: String
        let userName: String
        let lastText: String
        let lastTime: String
        let unReadCount: String
    }
    
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
//                self.dmUseCase.fetchDMList(playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4")
//                self.dmUseCase.fetchDMChat(
//                    playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
//                    roomID: "8ee29646-2bd6-41b6-8072-06bfdec2a83c",
//                    cursorDate: ""
//                )
                self.dmUseCase.fetchDMUnRead(
                    playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                    roomID: "8ee29646-2bd6-41b6-8072-06bfdec2a83c",
                    after: ""
                )
            }
            .bind(with: self) { _, response in
                switch response {
                case .success(let value):
//                    if value.isEmpty {
//                        viewState.onNext(.emptyList)
//                        print(value, "here")
//                    } else {
////                        updateDMListTableView.onNext(value)
//                        
//                        viewState.onNext(.chatting)
//                    }
                    print(value, "here")
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
