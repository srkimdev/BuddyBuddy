//
//  AddChannelViewController.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/27/24.
//

import UIKit

import SnapKit

final class AddChannelViewController: BaseViewController {
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
            make.bottom.equalTo(safeArea).inset(12)
            make.height.equalTo(44)
        }
    }
}
