//
//  ChannelTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelTableViewCell: BaseTableViewCell {
    private let iconImgView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
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
    
    func configureCell(data: MyChannel) {
        titleLabel.text = data.name
        // TODO: 안읽은 메세지 수 
    }
    
    func configureCell(isRead: Bool) {
        iconImgView.image = isRead ? .read : .unread
        titleLabel.font = isRead ?.body : .bodyBold
        titleLabel.textColor = isRead ?.gray1 : .black
        notificationView.isHidden = isRead
    }
}
