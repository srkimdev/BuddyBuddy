//
//  TitledTextField.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

final class TitledTextField: BaseView {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .title2
        view.textColor = .black
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.font = .body
        view.textColor = .black
        view.clearButtonMode = .whileEditing
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        view.leftViewMode = .always
        return view
    }()
    
    init(
        title: String,
        placeholder: String
    ) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray1]
        )
        
        super.init()
    }
    
    override func setHierarchy() { 
        [titleLabel, textField].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
    }
}
