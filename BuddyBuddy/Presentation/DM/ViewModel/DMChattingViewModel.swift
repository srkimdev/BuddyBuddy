//
//  DMChattingViewModel.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import UIKit

import RxCocoa
import RxSwift

final class DMChattingViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    private let coordinator: DMCoordinator
    private let dmUseCase: DMUseCaseInterface
    private let dmListInfo: DMListInfo
    
    init(
        coordinator: DMCoordinator,
        dmUseCase: DMUseCaseInterface,
        dmListInfo: DMListInfo
    ) {
        self.coordinator = coordinator
        self.dmUseCase = dmUseCase
        self.dmListInfo = dmListInfo
    }
    
    deinit {
        print("dmchatviewmodel deinit")
    }
    
    struct Input {
        let viewWillAppearTrigger: Observable<Void>
        let sendBtnTapped: Observable<Void>
        let plusBtnTapped: Observable<Void>
        let chatBarText: Observable<String>
        let imagePicker: Observable<[UIImage]>
    }
    
    struct Output {
        let updateDMListTableView: Driver<[ChatSection<DMHistory>]>
        let scrollToDown: Driver<Void>
        let removeChattingBarTextAndImage: Driver<Void>
        let plusBtnTapped: Driver<Void>
        let imagePicker: Driver<[UIImage]>
    }
    
    func transform(input: Input) -> Output {
        let updateDMListTableView = PublishSubject<[ChatSection<DMHistory>]>()
        let scrollToDown = PublishSubject<Void>()
        let removeChattingBarText = PublishSubject<Void>()
        
        input.viewWillAppearTrigger
            .flatMap {
                return self.dmUseCase.fetchDMHistory(
                    playgroundID: /*UserDefaultsManager.playgroundID*/"70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                    roomID: self.dmListInfo.roomID
                )
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    let chatHistory = value.map { $0.toChatType() }
                    
                    updateDMListTableView.onNext([ChatSection(items: chatHistory)])
                    scrollToDown.onNext(())
                    
                    owner.dmUseCase.connectSocket(roomID: owner.dmListInfo.roomID)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        self.dmUseCase.observeMessage(roomID: self.dmListInfo.roomID)
            .bind(with: self) { _, response in
                switch response {
                case .success(let value):
                    let chatHistory = value.map { $0.toChatType() }
                    updateDMListTableView.onNext([ChatSection(items: chatHistory)])
                    
                    scrollToDown.onNext(())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.sendBtnTapped
            .withLatestFrom(Observable.combineLatest(
                input.chatBarText,
                input.imagePicker
            ))
            .flatMap { (text, images) -> Single<Result<[DMHistory], Error>> in
                return self.dmUseCase.sendDM(
                    playgroundID: /*UserDefaultsManager.playgroundID*/"70b565b8-9ca1-483f-b812-15d3e57b5cf4",
                    roomID: self.dmListInfo.roomID,
                    message: text,
                    files: self.imageToData(imageArray: images)
                )
            }
            .bind(with: self) { _, result in
                switch result {
                case .success(let value):
                    let chatHistory = value.map { $0.toChatType() }
                    updateDMListTableView.onNext([ChatSection(items: chatHistory)])

                    scrollToDown.onNext(())
                    removeChattingBarText.onNext(())
                    
//                    owner.dmUseCase.disConnectSocket()
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
            
        return Output(
            updateDMListTableView: updateDMListTableView.asDriver(onErrorJustReturn: []),
            scrollToDown: scrollToDown.asDriver(onErrorJustReturn: ()),
            removeChattingBarTextAndImage: removeChattingBarText.asDriver(onErrorJustReturn: ()),
            plusBtnTapped: input.plusBtnTapped.asDriver(onErrorJustReturn: ()),
            imagePicker: input.imagePicker.asDriver(onErrorJustReturn: [])
        )
    }
}

extension DMChattingViewModel {
    private func imageToData(imageArray: [UIImage]) -> [Data] {
        var dataArray: [Data] = []
        
        for item in imageArray {
            if let data = item.jpegData(compressionQuality: 0.5) {
                dataArray.append(data)
            } else {
                return []
            }
        }
        return dataArray
    }
}
