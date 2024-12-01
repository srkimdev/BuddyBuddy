//
//  LoginButton.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/1/24.
//

import UIKit

import SnapKit

final class LoginButton: UIButton {
    private let loginImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    init(loginType: LoginType) {
        super.init(frame: .zero)
        
        setButtonImage(loginType)
        
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubview(loginImage)
    }
    
    private func setLayout() {
        loginImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setButtonImage(_ type: LoginType) {
        loginImage.image = UIImage(named: type.toImageName)
    }
}
