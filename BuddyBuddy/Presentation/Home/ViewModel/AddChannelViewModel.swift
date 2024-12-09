//
//  AddChannelViewModel.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/27/24.
//

import Foundation

import RxCocoa
import RxSwift

final class AddChannelViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let channelUseCase: ChannelUseCaseInterface
    private let coordinator: HomeCoordinator
    weak var delegate: ModalDelegate?
    
    init(
        channelUseCase: ChannelUseCaseInterface,
        coordinator: HomeCoordinator
    ) {
        self.channelUseCase = channelUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let nameInputText: Observable<String>
        let contentInputText: Observable<String>
        let okBtnTapped: Observable<Void>
    }
    
    struct Output {
        let nameText: Driver<String>
        let contentText: Driver<String>
        let okBtnState: Driver<ButtonState>
    }
    
    func transform(input: Input) -> Output {
        let nameText = BehaviorRelay(value: "")
        let contentText = BehaviorRelay(value: "")
        let okBtnState = BehaviorRelay<ButtonState>(value: .disable)
        
        input.nameInputText
            .bind(with: self) { _, input in
                var input = input
                
                while input.first == " " {
                    input.removeFirst()
                }
                
                nameText.accept(input)
                
                do {
                    let isValid = try input.isVaild(type: .name)
                    okBtnState.accept(isValid ? .enable : .disable)
                } catch {
                    print(error)
                    okBtnState.accept(.disable)
                }
            }.disposed(by: disposeBag)
        
        input.contentInputText
            .bind(with: self) { _, input in
                var input = input
                
                while input.first == " " {
                    input.removeFirst()
                }
                
                contentText.accept(input)
            }
            .disposed(by: disposeBag)
        
        input.okBtnTapped
            .withUnretained(self)
            .flatMap { ( owner, _ ) in
                return owner.channelUseCase.createChannel(
                    request: AddChannelReqeustDTO(
                        name: nameText.value,
                        description: contentText.value.isEmpty ? nil : contentText.value
                    )
                )
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let response):
                    owner.coordinator.dismissVC()
                    owner.delegate?.dismissModal(message: ToastMessage.createChannel.localized)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            nameText: nameText.asDriver(onErrorJustReturn: ""),
            contentText: contentText.asDriver(onErrorJustReturn: ""),
            okBtnState: okBtnState.asDriver(onErrorJustReturn: .disable)
        )
    }
}
