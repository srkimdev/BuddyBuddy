//
//  SystemImageLabelView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/14/24.
//

import UIKit

import SnapKit

/// view - height 40
final class SystemImageLabelView: BaseView {
    private let imgCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray2
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    private let imgView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.numberOfLines = 1
        return view
    }()
    
    init(imgName: String) {
        imgView.image = UIImage(systemName: imgName)?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
        
        super.init()
    }
    
    override func setHierarchy() {
        [imgCircleView, titleLabel]
            .forEach { addSubview($0) }
        [imgView]
            .forEach { imgCircleView.addSubview($0) }
    }
    
    override func setConstraints() {
        imgCircleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imgCircleView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        imgView.snp.makeConstraints { make in
            make.center.equalTo(imgCircleView)
            make.width.height.equalTo(30)
        }
        
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            imgCircleView.layer.cornerRadius = imgCircleView.bounds.width / 2
//        }
    }
    
    func setUI(
        label: String,
        font: UIFont?,
        fontColor: UIColor
    ) {
        titleLabel.text = label
        titleLabel.textColor = fontColor
        titleLabel.font = font
    }
}
