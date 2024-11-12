//
//  SearchImageType.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/12/24.
//

import Foundation

enum SearchImageType: String {
    case clock, channel, person
    
    var toImgTitle: String {
        switch self {
        case .clock:
            return "clock"
        case .channel:
            return "number"
        case .person:
            return "person"
        }
    }
}
