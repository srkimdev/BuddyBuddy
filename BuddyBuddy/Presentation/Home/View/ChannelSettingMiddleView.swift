//
//  ChannelSettingMiddleView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

final class ChannelSettingMiddleView: BaseView {
    private let memberCount: UILabel = {
        let view = UILabel()
        view.font = .title2
        view.textColor = .black
        view.textAlignment = .left
        view.text = "멤버(14)"
        return view
    }()
    
    let memberTableView: UITableView = {
        let view = UITableView()
        view.register(
            ChannelSettingCell.self,
            forCellReuseIdentifier: ChannelSettingCell.identifier
        )
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.rowHeight = 56
        return view
    }()
    
    override func setHierarchy() {
        [memberCount, memberTableView]
            .forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        memberCount.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        memberTableView.snp.makeConstraints { make in
            make.top.equalTo(memberCount.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setMemebrCount(count: Int) {
        memberCount.text = "멤버(\(count))"
    }
}
