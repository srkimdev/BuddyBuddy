//
//  ChannelAdminTableViewCell.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelAdminTableViewCell: BaseTableViewCell {
    private let profileImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private let profileNameLb: UILabel = {
        let view = UILabel()
        view.font = .bodyBold
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()
    private let emailLb: UILabel = {
        let view = UILabel()
        view.font = .body
        view.textColor = .gray1
        view.textAlignment = .left
        return view
    }()
    
    private let labelContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 0
        view.alignment = .leading
        return view
    }()
    
    override func setHierarchy() {
        contentView.backgroundColor = .white
        
        [profileImgView, labelContainerView]
            .forEach { contentView.addSubview($0) }
        [profileNameLb, emailLb]
            .forEach { labelContainerView.addArrangedSubview($0) }
    }
    override func setConstraints() {
        profileImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.leading.equalTo(profileImgView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            profileImgView.layer.cornerRadius = profileImgView.bounds.width / 2
        }
    }
    
    func setUserProfile(
        img: UIImage,
        name: String,
        email: String
    ) {
        profileImgView.image = img
        profileNameLb.text = name
        emailLb.text = email
    }
}
