//
//  ChannelSettingBottomView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelSettingBottomView: BaseView {
    let exitBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?
            .withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            )
        let view = UIButton(configuration: config)
        return view
    }()
    let adminBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "person.badge.key")?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
        let view = UIButton(configuration: config)
        return view
    }()
    let settingBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "gearshape")?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
        let view = UIButton(configuration: config)
        return view
    }()
    
    override func setHierarchy() {
        [exitBtn, adminBtn, settingBtn].forEach {
            addSubview($0)
        }
    }
    override func setConstraints() {
        exitBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(30)
        }
        settingBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(30)
        }
        adminBtn.snp.makeConstraints { make in
            make.trailing.equalTo(settingBtn.snp.leading).offset(-8)
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(30)
        }
        // TODO: 관리자인지 아닌지에 따라 adminBtn hidden 처리 필요함.
    }
    override func setView() {
        super.setView()
        
        backgroundColor = .gray2
    }
}
