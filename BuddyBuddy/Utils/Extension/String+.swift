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
    
    func toDate(format: _DateFormatter) -> Date? {
        _DateFormatter.standard.dateFormat = format.rawValue
        return _DateFormatter.standard.date(from: self)
    }
}
