//
//  String+.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate(format: BuddyDateFormatter) -> Date? {
        BuddyDateFormatter.standard.dateFormat = format.rawValue
        return BuddyDateFormatter.standard.date(from: self)
    }
}
