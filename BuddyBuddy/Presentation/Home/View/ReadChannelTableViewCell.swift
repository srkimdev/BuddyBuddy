//
//  DefaultChannelTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class ReadChannelTableViewCell: BaseTableViewCell {
    private let iconImgView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .gray1
        view.image = UIImage(systemName: "number")
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
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(iconImgView.snp.trailing).offset(12)
            make.height.equalTo(41)
        }
    }
    
    func configureCell(title: String) {
        titleLabel.text = title
    }
}
