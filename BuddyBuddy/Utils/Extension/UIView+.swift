//
//  UIView+.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/14/24.
//

import UIKit

extension UIView {
    func drawShadow(radius: CGFloat, size: CGSize) {
        let origin = self.bounds.origin
        let point = CGPoint(
            x: origin.x,
            y: origin.y + 7.8
        )
        let rect = CGRect(
            origin: point,
            size: size
        )
        
        layer.shadowPath = UIBezierPath(
            roundedRect: rect,
            cornerRadius: radius
        ).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}
