//
//  ImagePickerCollectionViewCell.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/27/24.
//

import UIKit

import SnapKit

final class ImagePickerCollectionViewCell: BaseCollectionViewCell {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    private let cancelButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(pointSize: 12)
        
        config.preferredSymbolConfigurationForImage = imgConfig
        config.image = UIImage(named: "xCircle")
        config.baseForegroundColor = .black
        
        view.configuration = config
        view.backgroundColor = .clear
        
        return view
    }()
    
    override func setHierarchy() {
        [imageView, cancelButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.9)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func designCell(_ transition: UIImage) {
        imageView.image = transition
    }
}
