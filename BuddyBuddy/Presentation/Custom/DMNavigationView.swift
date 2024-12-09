//
//  DMNavigationView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 12/5/24.
//

import UIKit

import SnapKit

final class DMNavigationView: BaseView {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.image = UIImage(named: "DM")
        return view
    }()
    private let navigationTitle: UILabel = {
        let view = UILabel()
        view.text = "DM"
        view.font = .title1
        return view
    }()
    
    override func setHierarchy() {
        [imageView, navigationTitle].forEach {
            addSubview($0)
        }
    }
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        navigationTitle.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
}
