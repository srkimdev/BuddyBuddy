//
//  ChannelSettingTopView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelSettingTopView: BaseView {
    private let channelNameLabel: UILabel = {
        let view = UILabel()
        view.font = .title1
        view.textAlignment = .left
        view.textColor = .black
        view.numberOfLines = .zero
        return view
    }()
    private let channelIntro: UILabel = {
        let view = UILabel()
        view.font = .body
        view.numberOfLines = .zero
        view.textColor = .gray1
        view.textAlignment = .left
        return view
    }()
    
    override func setHierarchy() {
        [channelNameLabel, channelIntro].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        channelNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(4)
        }
        channelIntro.snp.makeConstraints { make in
            make.top.equalTo(channelNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setChannelInfo(
        name: String,
        intro: String?
    ) {
        channelNameLabel.text = name
        if intro == nil {
            channelIntro.text = "채널 소개글이 없습니다."
        } else {
            channelIntro.text = intro
        }
    }
}
