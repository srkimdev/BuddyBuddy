//
//  String+.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation
import RegexBuilder

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate(format: BuddyDateFormatter) -> Date? {
        BuddyDateFormatter.standard.dateFormat = format.rawValue
        return BuddyDateFormatter.standard.date(from: self)
    }
    
    func isVaild(type: RegularExpression) throws -> Bool {
        if #available(iOS 16.0, *) {
            let regex = try Regex(type.rawValue)
            return self.wholeMatch(of: regex) != nil
        } else {
            let regex = try NSRegularExpression(pattern: type.rawValue)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        }
    }
}
