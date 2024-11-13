//
//  AlertType.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import Foundation

enum AlertType {
    case oneButton
    case twoButton
}

enum AlertButtonType: String {
    case confirm
    case cancel
    case exit
    case delete
    
    var toBtnTitle: String {
        switch self {
        case .confirm:
            return "Confirm"
        case .cancel:
            return "Cancel"
        case .exit:
            return "Exit"
        case .delete:
            return "Delete"
        }
    }
}
