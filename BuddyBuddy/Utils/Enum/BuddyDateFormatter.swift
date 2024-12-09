//
//  BuddyDateFormatter.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

enum BuddyDateFormatter {
    static let standard = DateFormatter()
    
    case defaultDate
    case simpleDate
    
    var value: String {
        switch self {
        case .defaultDate:
            return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .simpleDate:
            return "SimpleDate".localized()
        }
    }
}
