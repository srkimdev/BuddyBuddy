//
//  RoundedButton.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

final class RoundedButton: UIButton {
    
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
    
    func setupBtn(
        title: String,
        bgColor: UIColor,
        txtColor: UIColor,
        btnType: RoundedButtonType
    ) {
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
