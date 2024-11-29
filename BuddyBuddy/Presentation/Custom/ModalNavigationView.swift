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
    private let titleLabel: UILabel = {
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
        titleLabel.text = title
        
        super.init()
    }
    
    override func setHierarchy() {
        [backBtn, titleLabel, bottomBar].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalToSuperview().offset(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(3)
            make.centerX.equalToSuperview()
        }
        bottomBar.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
