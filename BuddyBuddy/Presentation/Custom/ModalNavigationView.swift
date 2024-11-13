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
    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1.withAlphaComponent(0.5)
        return view
    }()
    
    init(title: String) {
        titleLb.text = title
        
        super.init()
    }
    
    override func setHierarchy() {
        [backBtn, titleLb, bottomBar]
            .forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        backgroundColor = .white
        
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        bottomBar.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
