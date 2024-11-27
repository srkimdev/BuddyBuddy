//
//  AddChannelViewController.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/27/24.
//

import UIKit

import SnapKit

final class AddChannelViewController: BaseViewController {
    private let navigationView: ModalNavigationView = ModalNavigationView(title: "채널 생성")
    private let channelNameTextField: TitledTextField = TitledTextField(
        title: "채널 이름",
        placeholder: "채널 이름을 입력하세요 (필수)"
    )
    private let channelContentTextField: TitledTextField = TitledTextField(
        title: "채널 이름",
        placeholder: "채널 이름을 입력하세요 (필수)"
    )
    
    override func setHierarchy() {
        [navigationView, channelNameTextField, channelContentTextField].forEach {
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
    }
}
