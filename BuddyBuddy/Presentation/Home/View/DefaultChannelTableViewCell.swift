//
//  DefaultChannelTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class DefaultChannelTableViewCell: BaseTableViewCell {
    private let iconImgView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .gray1
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.body
        view.textColor = .gray1
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
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
    }
    
    func configureCell(
        title: String,
        image: String
    ) {
        titleLabel.text = title
        iconImgView.image = UIImage(systemName: image)
        
        if image == "plus" {
            titleLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.leading.equalTo(iconImgView.snp.trailing).offset(12)
                make.height.equalTo(48)
            }
        } else {
            titleLabel.snp.remakeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.leading.equalTo(iconImgView.snp.trailing).offset(12)
                make.height.equalTo(41)
            }
        }
    }
}
