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
    
    func localized<T: CVarArg>(_ args: T...) -> String {
        let format = NSLocalizedString(self, comment: "")
        return String(format: format, arguments: args)
    }
    
    func toDate(format: BuddyDateFormatter) -> Date? {
        BuddyDateFormatter.standard.dateFormat = format.rawValue
        return BuddyDateFormatter.standard.date(from: self)
    }
}
