//
//  ProfileBottomView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/14/24.
//

import UIKit

import SnapKit

/// height - safeArea의 0.3
final class ProfileBottomView: BaseView {
    private let nameView: SystemImageLabelView = SystemImageLabelView(imgName: "person")
    private let emailView: SystemImageLabelView = SystemImageLabelView(imgName: "envelope")
    let dmBtn: RoundedButton = RoundedButton(
        title: "DM",
        bgColor: .primary,
        txtColor: .secondary,
        btnType: .generalBtn
    )
    
    override func setHierarchy() {
        [nameView, emailView, dmBtn].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        dmBtn.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setProfileView(
        name: String,
        email: String
    ) {
        nameView.setUI(
            label: name,
            font: .title2,
            fontColor: .black
        )
        emailView.setUI(
            label: email,
            font: .body,
            fontColor: .gray2
        )
    }
}
