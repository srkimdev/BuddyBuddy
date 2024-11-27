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
            .bind(with: self) { owner, input in
                nameInputText.accept(input)
                okBtnState.accept((1...30) ~= input.count ? .enable : .disable)
                do {
                    let isValid = try input.isVaild(type: .name)
                    print("Is valid email: \(isValid)")
                } catch {
                    print("Error validating email: \(error)")
                }
            }.disposed(by: disposeBag)
        
//        input.nameInputText
//            .bind(with: self) { _, input in
//                nameInputText.accept(input)
//                do {
//                    let isValid = try input.isVaild(type: .name)
//                    okBtnState.accept(isValid ? .enable : .disable)
//                } catch {
//                    print("Error validating channel name: \(error)")
//                    okBtnState.accept(.disable)
//                }
//            }.disposed(by: disposeBag)
        
        input.contentInputText
            .bind(to: contentInputText)
            .disposed(by: disposeBag)
        
        input.okBtnTapped
            .bind(with: self) { owner, _ in
                // TODO: API 통신
            }.disposed(by: disposeBag)
        
        return Output(okBtnState: okBtnState.asDriver(onErrorJustReturn: .disable))
    }
}
