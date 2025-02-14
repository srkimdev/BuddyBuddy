//
//  SpeechBubbleView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import UIKit

import SnapKit

final class SpeechBubbleView: BaseView {
    private let background: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray1.cgColor
        return view
    }()
    let content: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    init(text: String) {
        super.init()
        content.text = text
    }
    
    override func setHierarchy() {
        addSubview(background)
        background.addSubview(content)
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func updateText(_ text: String) {
        content.text = text
    }
}
