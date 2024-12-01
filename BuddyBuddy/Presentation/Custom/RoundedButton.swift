//
//  RoundedButton.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

final class RoundedButton: UIButton {
    private var title: String?
    
    init(btnType: RoundedButtonType) {
        super.init(frame: .zero)
        clipsToBounds = true
        layer.cornerRadius = btnType.toBtnRadius
    }
    
    init(
        title: String,
        bgColor: UIColor,
        txtColor: UIColor,
        btnType: RoundedButtonType
    ) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = btnType.toBtnRadius
        
        setupBtn(
            title: title,
            bgColor: bgColor,
            txtColor: txtColor,
            btnType: btnType
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBtn(
        bgColor: UIColor,
        txtColor: UIColor
    ) {
        guard var config = configuration,
              let title else { return }
        
        let attributes = AttributeContainer([
            .font: UIFont.title2 as Any,
            .foregroundColor: txtColor
        ])
        
        config.baseBackgroundColor = bgColor
        config.attributedTitle = AttributedString.init(
            title,
            attributes: attributes
        )
        
        configuration = config
    }
    
    func setupBtn(
        title: String,
        bgColor: UIColor,
        txtColor: UIColor,
        btnType: RoundedButtonType
    ) {
        self.title = title
        
        var config = UIButton.Configuration.filled()
        
        config.baseBackgroundColor = bgColor
        let attributes = AttributeContainer([
            .font: UIFont.title2 as Any,
            .foregroundColor: btnType == .alertBtn ? UIColor.secondary : txtColor
        ])
        config.attributedTitle = AttributedString(title, attributes: attributes)
        
        configuration = config
    }
}
