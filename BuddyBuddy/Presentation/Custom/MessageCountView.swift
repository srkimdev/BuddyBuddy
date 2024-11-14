//
//  MessageCountView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/11/24.
//

import UIKit

import SnapKit

final class MessageCountView: BaseView {
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 12
        return view
    }()
    private let messageCount: UILabel = {
        let view = UILabel()
        view.textColor = .secondary
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .center
        return view
    }()
    
    init(count: Int) {
        super.init()
        messageCount.text = "\(count)"
    }
    
    override func setHierarchy() {
        addSubview(background)
        background.addSubview(messageCount)
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.edges.equalToSuperview()
        }
        messageCount.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
