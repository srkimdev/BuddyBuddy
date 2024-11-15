//
//  BaseTableViewCell.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        contentView.backgroundColor = .white
        
        setHierarchy()
        setConstraints()
        setBackground()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() { }
    
    func setConstraints() { }
    
    func setBackground() {
        contentView.backgroundColor = .white
    }
}
extension BaseTableViewCell: Reusables { }
