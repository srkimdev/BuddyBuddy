//
//  BubbleImageStackView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/26/24.
//

import UIKit

import SnapKit

final class BubbleImageStackView: UIStackView {
    let speechBubble: SpeechBubbleView = {
        let view = SpeechBubbleView(text: "")
        return view
    }()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackView()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStackView() {
        axis = .vertical
        alignment = .leading
        spacing = 10
        
        addArrangedSubview(speechBubble)
        addArrangedSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
