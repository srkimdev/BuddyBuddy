//
//  AddChannelViewController.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/27/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class AddChannelViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let vm: AddChannelViewModel
    
    private let navigationView: ModalNavigationView
    = ModalNavigationView(title: "CreateChannel".localized())
    private let channelNameTextField: TitledTextField = TitledTextField(
        title: "ChannelName".localized(),
        placeholder: "ChannelNamePlaceholder".localized()
    )
    private let channelContentTextField: TitledTextField = TitledTextField(
        title: "ChannelContent".localized(),
        placeholder: "ChannelContentPlaceholder".localized()
    )
    private let okBtn: RoundedButton = {
        let view = RoundedButton(
            title: "OK".localized(),
            bgColor: .gray2,
            txtColor: .gray1,
            btnType: .generalBtn
        )
        
        view.isEnabled = false
        return view
    }()
    
    init(vm: AddChannelViewModel) {
        self.vm = vm
        super.init()
    }
    
    override func bind() {
        let input = AddChannelViewModel.Input(
            nameInputText: channelNameTextField.textField.rx.text.orEmpty.asObservable(),
            contentInputText: channelContentTextField.textField.rx.text.orEmpty.asObservable(),
            okBtnTapped: okBtn.rx.tap.asObservable()
        )
        let output = vm.transform(input: input)
        
        output.nameText
            .drive(with: self) { owner, text in
                owner.channelNameTextField.textField.text = text
            }
            .disposed(by: disposeBag)
        
        output.contentText
            .drive(with: self) { owner, text in
                owner.channelContentTextField.textField.text = text
            }
            .disposed(by: disposeBag)
        
        output.okBtnState
            .drive(with: self) { owner, type in
                switch type {
                case .disable:
                    owner.okBtn.isEnabled = false
                    owner.okBtn.updateBtn(
                        bgColor: .gray2,
                        txtColor: .gray1
                    )
                case .enable:
                    owner.okBtn.isEnabled = true
                    owner.okBtn.updateBtn(
                        bgColor: .primary,
                        txtColor: .secondary
                    )
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func setView() {
        super.setView()
        
        view.backgroundColor = .gray3
    }
    
    override func setHierarchy() {
        [navigationView, channelNameTextField, channelContentTextField, okBtn].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        channelNameTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(76)
        }
        channelContentTextField.snp.makeConstraints { make in
            make.top.equalTo(channelNameTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(76)
        }
        okBtn.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(keyboardLayout.snp.top).offset(-12)
            make.height.equalTo(44)
        }
    }
}
