//
//  RegularExpression.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/28/24.
//

import Foundation

enum RegularExpression: String {
    case name = "^(?=.*[A-Za-z]|(?=.*[가-힣]{1}))(?![0-9]+)[A-Za-z가-힣]{1,30}$"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case phone = "01[0-1,7]-[0-9]{3,4}-[0-9]{4}$"
}
