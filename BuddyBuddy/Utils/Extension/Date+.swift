//
//  Date+.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

extension Date {
    func toString(format: BuddyDateFormatter) -> String {
        BuddyDateFormatter.standard.timeStyle = .none
        BuddyDateFormatter.standard.dateFormat = format.rawValue
        return BuddyDateFormatter.standard.string(from: self)
    }
}
