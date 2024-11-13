//
//  UnreadChannelTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class UnreadChannelTableViewCell: BaseTableViewCell {
    private let iconImgView: UIImageView = {
        let view = UIImageView()
        view.image = .unread
        return  view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.bodyBold
        return view
    }()
    private let notificationView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func setHierarchy() {
        [iconImgView, titleLabel, notificationView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        iconImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(iconImgView.snp.trailing).offset(12)
            make.height.equalTo(41)
        }
        
        notificationView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.size.equalTo(10)
        }
    }
    
    func configureCell(data: String) {
        titleLabel.text = data
    }
}
