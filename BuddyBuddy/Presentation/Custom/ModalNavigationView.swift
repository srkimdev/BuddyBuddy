//
//  ModalNavigationView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import SnapKit

final class ModalNavigationView: BaseView {
    let backBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
        config.imagePadding = 10
        let view = UIButton(configuration: config)
        return view
    }()
    private let titleLb: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .naviTitle
        return view
    }()
    
    init(title: String) {
        titleLb.text = title
        
        super.init()
    }
    
    override func setHierarchy() {
        [backBtn, titleLb]
            .forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
