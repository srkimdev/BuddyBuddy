//
//  DMViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

import RxSwift
import RxCocoa

struct DMListInfo {
    let profileImg: String
    let userName: String
    let lastText: String
    let lastTime: String
    let unReadCount: Int
    let roomID: String
}

final class DMListViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let dmUseCase: DMUseCaseInterface
    private let coordinator: DMCoordinator
    
    init(
        dmUseCase: DMUseCaseInterface,
        coordinator: DMCoordinator
    ) {
        self.dmUseCase = dmUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[DMListInfo]>
        let viewState: Driver<DMListState>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[DMListInfo]>()
        let viewState = PublishSubject<DMListState>()
        
        input.viewWillAppearTrigger
            .flatMapLatest {
                self.dmUseCase.fetchDMList(
                    playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4"
                ).asObservable()
            }
            .flatMap { result -> Observable<[DMListInfo]> in
                switch result {
                case .success(let dmLists):
                    let dmListInfoRequests = dmLists.map { dmList in
                        Observable.zip(
                            self.dmUseCase.fetchDMHistory(
                                playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                                roomID: dmList.room_id,
                                cursorDate: ""
                            )
                            .asObservable(),
                            self.dmUseCase.fetchDMUnRead(
                                playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                                roomID: dmList.room_id,
                                after: ""
                            )
                            .asObservable()
                        )
                        .flatMap { history, unread -> Observable<DMListInfo> in
                            switch (history, unread) {
                            case (.success(let historyArray), .success(let unreadData)):
                                return Observable.just(DMListInfo(
                                    profileImg: dmList.user.profileImg ?? "",
                                    userName: dmList.user.nickname,
                                    lastText: historyArray.last?.content ?? "",
                                    lastTime: historyArray.last?.createdAt ?? "",
                                    unReadCount: unreadData.count,
                                    roomID: dmList.room_id
                                ))
                            case (.failure(let error), _), (_, .failure(let error)):
                                return Observable.error(error)
                            }
                        }
                    }
                    return Observable.zip(dmListInfoRequests)
                    
                case .failure(let error):
                    return Observable.error(error)
                }
            }
            .bind(with: self) { _, response in
                if response.isEmpty {
                    viewState.onNext(.emptyList)
                } else {
                    updateDMListTableView.onNext(response)
                    viewState.onNext(.chatting)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []),
            viewState: viewState.asDriver(onErrorJustReturn: .emptyList)
        )
    }
 
    func toDMChatting(_ dmListInfo: DMListInfo) {
        coordinator.toDMChatting(dmListInfo)
    }
}
