//
//  LeftAlignButton.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import UIKit

final class LeftAlignButton: UIButton {
    private let title: String
    private let icon: UIImage?
    
    init(
        title: String,
        icon: UIImage?,
        backgroundColor: UIColor = .clear
    ) {
        self.title = title
        self.icon = icon
        
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        setupBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBtn() {
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(pointSize: 13)
        var attr = AttributedString.init(title.localized())
        
        attr.font = UIFont.body
        
        config.attributedTitle = attr
        config.preferredSymbolConfigurationForImage = imgConfig
        config.image = icon
        config.imagePlacement = .leading
        config.imagePadding = 12
        config.baseForegroundColor = .gray1
        config.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 0
        )
        
        configuration = config
        contentHorizontalAlignment = .left
    }
}
