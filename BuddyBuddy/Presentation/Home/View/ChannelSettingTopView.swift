//
//  ChannelSettingTopView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelSettingTopView: BaseView {
    private let channelNameLb: UILabel = {
        let view = UILabel()
        view.font = .title1
        view.textAlignment = .left
        view.textColor = .black
        view.numberOfLines = .zero
        view.text = "# 아라,성률,지수와 함께하는 얼렁뚱땅 언어교환앱"
        return view
    }()
    private let channelIntro: UILabel = {
        let view = UILabel()
        view.font = .body
        view.numberOfLines = .zero
        view.textColor = .gray1
        view.textAlignment = .left
        view.text = """
안녕하세요 새싹 여러분? 심심하셨죠? 이 채널은 나머지 모든 것을 위한 채널이에요. 팀원들이 농담하거나 순간적인 아이디어를 공유하는 곳이죠! 마음껏 즐기세요!
"""
        return view
    }()
    
    override func setHierarchy() {
        [channelNameLb, channelIntro]
            .forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        channelNameLb.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(4)
        }
        channelIntro.snp.makeConstraints { make in
            make.top.equalTo(channelNameLb.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setChannelInfo(name: String, intro: String) {
        channelNameLb.text = name
        channelIntro.text = intro
    }
}
