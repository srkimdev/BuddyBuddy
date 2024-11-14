//
//  RoundedButtonType.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import Foundation

enum RoundedButtonType {
    case alertBtn
    case generalBtn
    
    var toBtnRadius: CGFloat {
        switch self {
        case .alertBtn:
            return 12
        case .generalBtn:
            return 16
        }
    }
}
