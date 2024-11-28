//
//  BubbleImageStackView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/26/24.
//

import UIKit

import SnapKit

//final class BubbleImageStackView: UIStackView {
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setStackView()
//        setConstraints()
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setStackView() {
//        axis = .vertical
//        alignment = .leading
//        spacing = 4
//        
//        addArrangedSubview(speechBubble)
//        addArrangedSubview(imageView)
//        
////        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
////        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//    }
//    
//    private func setConstraints() {
//        imageView.snp.makeConstraints { make in
//            make.width.equalTo(self)
////            make.height.equalTo(80).priority(.medium)
////            make.height.lessThanOrEqualTo(80)
//            make.height.equalTo(160)
//        }
//    }
//}
