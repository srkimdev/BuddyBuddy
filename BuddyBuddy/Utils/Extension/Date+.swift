//
//  Date+.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

extension Date {
    func toString(format: _DateFormatter) -> String {
        _DateFormatter.standard.timeStyle = .none
        _DateFormatter.standard.dateFormat = format.rawValue
        return _DateFormatter.standard.string(from: self)
    }
}
