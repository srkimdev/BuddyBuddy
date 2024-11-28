//
//  ToastMessageLabel.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/28/24.
//

import UIKit

class ToastMessageLabel: UILabel {
    private var padding = UIEdgeInsets(top: 13.0, left: 16.0, bottom: 13.0, right: 16.0)

    convenience init(padding: UIEdgeInsets) {
        self.init(frame: .zero)
        self.padding = padding
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
    private func setUI() {
        backgroundColor = .primary
        textColor = .secondary
        font = UIFont.body
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
