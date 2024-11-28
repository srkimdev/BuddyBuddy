//
//  TextTableViewCell.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/28/24.
//

import UIKit

import SnapKit

final class DMTextTableViewCell: BaseTableViewCell {
    private let profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        return view
    }()
    private let userName: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    private let speechBubble: SpeechBubbleView = {
        let view = SpeechBubbleView(text: "")
        return view
    }()
    private let chatTime: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        bubbleImageStackView.speechBubble.updateText("")
//        bubbleImageStackView.imageView.updateLayout(imageViews: [])
    }
    
    override func setHierarchy() {
        [profileImage, userName, speechBubble, chatTime].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(15)
        }
        speechBubble.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(8)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        chatTime.snp.makeConstraints { make in
            make.bottom.equalTo(speechBubble.snp.bottom)
            make.leading.equalTo(speechBubble.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(30)
        }
    }
    
    func designCell(_ transition: DMHistoryTable) {
        profileImage.backgroundColor = .lightGray
        userName.text = transition.user?.nickname
        chatTime.text = "11:55 오전"
        
        speechBubble.updateText(transition.content)
    }
}
