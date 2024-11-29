//
//  BuddyAlert.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/26/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class BuddyAlert: BaseView {
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    private let labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        return view
    }()
    private let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 8
        return view
    }()
    /// 제목 라벨
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .title2
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    /// 본문 라벨
    private let messageLabel: UILabel = {
        let view = UILabel()
        view.font = .body
        view.textColor = .gray1
        view.textAlignment = .center
        view.numberOfLines = .zero
        return view
    }()
    /// 왼쪽 버튼
    let leftButton: RoundedButton = RoundedButton(btnType: .alertBtn)
    /// 오른쪽 버튼
    let rightButton: RoundedButton = RoundedButton(btnType: .alertBtn)
    private let hasTwoButton: Bool
    
    init(
        title: String,
        leftButtonTitle: String? = nil,
        rightButtonTitle: String,
        hasTwoButton: Bool
    ) {
        self.hasTwoButton = hasTwoButton
        
        super.init()
        
        titleLabel.text = title
        setButtonTitle(
            left: leftButtonTitle,
            right: rightButtonTitle
        )
    }
    
    override func setHierarchy() {
        addSubview(containerView)
        
        [labelStackView, buttonStackView].forEach {
            containerView.addSubview($0)
        }
        [titleLabel, messageLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        if hasTwoButton {
            [leftButton, rightButton].forEach {
                buttonStackView.addArrangedSubview($0)
            }
        } else {
            buttonStackView.addArrangedSubview(rightButton)
        }
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.greaterThanOrEqualTo(138)
        }
        labelStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func setView() {
        backgroundColor = UIColor.gray1.withAlphaComponent(0.5)
    }
    
    func setButtonTitle(
        left: String?,
        right: String
    ) {
        leftButton.setupBtn(
            title: left ?? "",
            bgColor: .gray2,
            txtColor: .secondary,
            btnType: .alertBtn
        )
        rightButton.setupBtn(
            title: right,
            bgColor: .primary,
            txtColor: .secondary,
            btnType: .alertBtn
        )
    }
    
    func setMessageBody(_ text: AlertLiteral) {
        messageLabel.text = text.toMessage
    }
    
    func setTitleBody(_ text: AlertLiteral) {
        titleLabel.text = text.toTitle
    }
}
