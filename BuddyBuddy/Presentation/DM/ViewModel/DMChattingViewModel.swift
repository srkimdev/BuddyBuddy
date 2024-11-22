//
//  DMChattingViewModel.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DMChattingViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    private let coordinator: DMCoordinator
    private let dmUseCase: DMUseCaseInterface
    private let dmListInfo: DMListInfo
    private let realmRepository: RealmRepository<DMHistoryTable>
    
    init(
        coordinator: DMCoordinator,
        dmUseCase: DMUseCaseInterface,
        dmListInfo: DMListInfo,
        realmRepository: RealmRepository<DMHistoryTable>
    ) {
        self.coordinator = coordinator
        self.dmUseCase = dmUseCase
        self.dmListInfo = dmListInfo
        self.realmRepository = realmRepository
    }
    
    deinit {
        print("dmchatviewmodel deinit")
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
        let sendBtnTapped: Observable<String>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[DMHistoryTable]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[DMHistoryTable]>()
        let receiveMessage = PublishSubject<Void>()
        
        input.viewWillAppearTrigger
            .flatMap {
                let chatHistory = self.realmRepository.readAllItem().filter {
                    $0.roomID == self.dmListInfo.roomID
                }/*.sorted(by: { $0.createdAt < $1.createdAt })*/
                
                return self.dmUseCase.fetchDMHistory(
                    playgroundID: "70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                    roomID: self.dmListInfo.roomID,
                    cursorDate: chatHistory.last?.createdAt ?? ""
                )
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    let dmHistoryTable = value.map { $0.toTable() }
                    dmHistoryTable.forEach { owner.realmRepository.updateItem($0) }
                    
                    let chatHistory = owner.realmRepository.readAllItem().filter {
                        $0.roomID == owner.dmListInfo.roomID
                    }
                    
                    updateDMListTableView.onNext(chatHistory)
                    
                    owner.dmUseCase.connectSocket(roomID: owner.dmListInfo.roomID)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        self.dmUseCase.observeMessage()
            .bind(with: self) { owner, value in
                owner.realmRepository.updateItem(value)
                
                let chatHistory = self.realmRepository.readAllItem().filter {
                    $0.roomID == self.dmListInfo.roomID
                }
                
                updateDMListTableView.onNext(chatHistory)
            }
            .disposed(by: disposeBag)
        
        input.sendBtnTapped
            .bind(with: self) { owner, value in
//                owner.dmUseCase.sendMessage(roomID: self.dmListInfo.roomID, message: value)
                
            }
            .disposed(by: disposeBag)
            
        return Output(updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []))
    }
    
    private func receiveChat() {
//        socket.on("chat") { [weak self] data, ack in
//            guard let message = data[0] as? String else { return }
//        }
    }
    
}
