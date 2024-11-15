//
//  UnderlineSegmentedControl.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/12/24.
//

import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        removeBackgroundAndDivider()
        setFont()
    }
    override init(items: [Any]?) {
        super.init(items: items)
        removeBackgroundAndDivider()
        setFont()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(
            image,
            for: .normal,
            barMetrics: .default
        )
        self.setBackgroundImage(
            image,
            for: .selected,
            barMetrics: .default
        )
        self.setBackgroundImage(
            image,
            for: .highlighted,
            barMetrics: .default
        )
        self.setDividerImage(
            image,
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(
            x: xPosition,
            y: yPosition,
            width: width,
            height: height
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .gray1
        self.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let underlineFinalXPosition 
        = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        
        UIView.animate(
            withDuration: 0.1,
            animations: { self.underlineView.frame.origin.x = underlineFinalXPosition }
        )
    }
    
    private func setFont() {
        let customAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.title2 as Any
        ]
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.body as Any
        ]
        self.setTitleTextAttributes(
            normalAttributes,
            for: .normal
        )
        self.setTitleTextAttributes(
            customAttributes,
            for: .selected
        )
    }
}
