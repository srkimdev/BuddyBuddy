//
//  DMChattingTableViewCell.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import UIKit

import SnapKit

final class DMChattingTableViewCell: BaseTableViewCell {
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
    private let pickerImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        return view
    }()
    private let chatTime: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    private let chatImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        bubbleImageStackView.speechBubble.updateText("")
//        bubbleImageStackView.imageView.updateLayout(imageViews: [])
    }
    
    override func setHierarchy() {
        [profileImage, userName, chatImageStackView, chatTime].forEach {
            contentView.addSubview($0)
        }
        [speechBubble, pickerImage].forEach {
            chatImageStackView.addArrangedSubview($0)
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
        chatImageStackView.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(8)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        chatTime.snp.makeConstraints { make in
            make.bottom.equalTo(chatImageStackView.snp.bottom)
            make.leading.equalTo(chatImageStackView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(30)
//            make.trailing.equalToSuperview().inset(30)
        }
        pickerImage.snp.makeConstraints { make in
//            make.height.equalTo(80)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func designCell(_ transition: DMHistoryTable) {
        profileImage.backgroundColor = .lightGray
        userName.text = transition.user?.nickname
        chatTime.text = "11:55 오전"
        
        speechBubble.updateText(transition.content)
        updateCellByMessageType(transition)
    }
}

extension DMChattingTableViewCell {
    func updateCellByMessageType(_ transition: DMHistoryTable) {
        if transition.content.isEmpty && !transition.files.isEmpty {
            speechBubble.isHidden = true
//            chatTime.snp.remakeConstraints { make in
//                make.bottom.equalTo(chatImageStackView.snp.bottom)
//                make.leading.equalTo(chatImageStackView.snp.trailing).offset(8)
////                make.trailing.lessThanOrEqualToSuperview().inset(30)
//                make.trailing.equalToSuperview().inset(30)
//            }
            print("1")
//            chatImageStackView.snp.remakeConstraints { make in
//                make.top.equalTo(userName.snp.bottom).offset(8)
//                make.leading.equalTo(profileImage.snp.trailing).offset(8)
//                make.bottom.equalToSuperview().inset(8)
//                make.trailing.equalToSuperview().inset(38 + chatTime.frame.width)
//            }
        } else if !transition.content.isEmpty && !transition.files.isEmpty {
//            speechBubble.updateText(transition.content)
//            pickerImage.image = transition.files[0]
//            bubbleImageStackView.imageView.updateLayout(imageViews: Array(transition.files))
            print("2")
        } else {
            pickerImage.isHidden = true
//            speechBubble.updateText(transition.content)
            print("3")
        }
    }
}
