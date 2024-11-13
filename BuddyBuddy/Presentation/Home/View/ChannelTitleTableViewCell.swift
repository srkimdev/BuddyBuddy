//
//  ChannelTitleTableViewCell.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import UIKit

import SnapKit

final class ChannelTitleTableViewCell: BaseTableViewCell {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Channel".localized()
        view.font = .title2
        return view
    }()
    private let chevronImgView: UIImageView = {
        let view = UIImageView()
        view.image = .chevronDown
        return view
    }()
    
    override func setHierarchy() {
        [titleLabel, chevronImgView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(13)
            make.height.equalTo(56)
        }
        
        chevronImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(13)
            make.size.equalTo(24)
        }
    }
    
    func configureCell(data: String) {
        chevronImgView.image = UIImage(named: data)
    }
}
