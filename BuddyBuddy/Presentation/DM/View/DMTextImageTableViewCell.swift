//
//  DMTextImageTableViewCell.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/28/24.
//

import UIKit

import SnapKit

final class DMTextImageTableViewCell: BaseTableViewCell {
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
    private let pickerImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.distribution = .fillEqually
        view.layer.cornerRadius = 10
        return view
    }()
    private let topImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private let middleImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
        return view
    }()
    private let bottomImageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
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
        
    }
    
    override func setHierarchy() {
        [profileImage, userName, speechBubble, pickerImageStackView, chatTime].forEach {
            contentView.addSubview($0)
        }
        [topImageView, middleImageStackView, bottomImageStackView].forEach {
            pickerImageStackView.addArrangedSubview($0)
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
            make.trailing.lessThanOrEqualToSuperview().inset(92)
        }
        pickerImageStackView.snp.makeConstraints { make in
            make.top.equalTo(speechBubble.snp.bottom).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        middleImageStackView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        bottomImageStackView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        chatTime.snp.makeConstraints { make in
            make.leading.equalTo(pickerImageStackView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func designCell(_ transition: DMHistory) {
        profileImage.backgroundColor = .lightGray
        userName.text = transition.user.nickname
        chatTime.text = "11:55 오전"
        
        speechBubble.updateText(transition.content)
        middleImageStackView.backgroundColor = .gray
        bottomImageStackView.backgroundColor = .yellow
        
        imageType(imageCount: transition.files.count)
    }
    
    private func imageType(imageCount: Int) {
        switch imageCount {
        case 1:
            middleImageStackView.isHidden = true
            bottomImageStackView.isHidden = true
            
        case 2:
            topImageView.isHidden = true
            bottomImageStackView.isHidden = true
        case 3:
            topImageView.isHidden = true
            bottomImageStackView.isHidden = true
        case 4:
            topImageView.isHidden = true
        case 5:
            topImageView.isHidden = true
        default: break
        }
    }
}
