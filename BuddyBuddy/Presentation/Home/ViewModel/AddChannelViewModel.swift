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
    
    init(channelUseCase: ChannelUseCaseInterface) {
        self.channelUseCase = channelUseCase
    }
    
    struct Input {
        let nameInputText: Observable<String>
        let contentInputText: Observable<String>
        let okBtnTapped: Observable<Void>
    }
    
    struct Output {
        let okBtnState: Driver<ButtonState>
    }
    
    func transform(input: Input) -> Output {
        let nameInputText = BehaviorRelay(value: "")
        let contentInputText = BehaviorRelay(value: "")
        let okBtnState = BehaviorRelay<ButtonState>(value: .disable)
        
        input.nameInputText
            .bind(with: self) { _, input in
                nameInputText.accept(input)
                do {
                    let isValid = try input.isVaild(type: .name)
                    okBtnState.accept(isValid ? .enable : .disable)
                } catch {
                    print(error)
                    okBtnState.accept(.disable)
                }
            }.disposed(by: disposeBag)
        
        input.contentInputText
            .bind(to: contentInputText)
            .disposed(by: disposeBag)
        
        input.okBtnTapped
            .withUnretained(self)
            .flatMap { _ in
                return self.channelUseCase.createChannel(
                    request: AddChannelReqeustDTO(
                        name: nameInputText.value,
                        description: contentInputText.value.isEmpty ? nil : contentInputText.value
                    )
                )
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let response):
                    // TODO: 화면 전환
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        
        return Output(okBtnState: okBtnState.asDriver(onErrorJustReturn: .disable))
    }
}
