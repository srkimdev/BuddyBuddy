//
//  DefaultChannelTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class DefaultChannelTableViewCell: BaseTableViewCell {
    private let iconImgView: UIImageView = UIImageView()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.body
        return view
    }()
    
    override func setHierarchy() {
        [iconImgView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        iconImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImgView).inset(16)
        }
    }
}
