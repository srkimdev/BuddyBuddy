//
//  DynamicImageStackView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/26/24.
//

import UIKit

final class DynamicImageStackView: UIStackView {
    private let topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
        return view
    }()
    private let bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .fillEqually
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
        spacing = 4
        distribution = .fillEqually
    }
    
    private func setConstraints() {
        addArrangedSubview(topStackView)
        addArrangedSubview(bottomStackView)
    }
    
    func updateLayout(imageViews: [String]) {
        
        topStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        bottomStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch imageViews.count {
        case 1:
//            topStackView.addArrangedSubview(imageViews[0])
            topStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
        case 2:
            for imageView in imageViews {
//                topStackView.addArrangedSubview(imageView)
                topStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
            }
        case 3:
            for imageView in imageViews {
//                topStackView.addArrangedSubview(imageView)
                topStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
            }
        case 4:
            for (index, imageView) in imageViews.enumerated() {
                if index < 2 {
//                    topStackView.addArrangedSubview(imageView)
                    topStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
                } else {
//                    bottomStackView.addArrangedSubview(imageView)
                    bottomStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
                }
            }
        case 5:
            for (index, imageView) in imageViews.enumerated() {
                if index < 3 {
//                    topStackView.addArrangedSubview(imageView)
                    topStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
                } else {
//                    bottomStackView.addArrangedSubview(imageView)
                    bottomStackView.addArrangedSubview(UIImageView(image: UIImage(systemName: "star")))
                }
            }
        default: break
            
        }
        
        bottomStackView.isHidden = imageViews.count <= 3
    }
}
