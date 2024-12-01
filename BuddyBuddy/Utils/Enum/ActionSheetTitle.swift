//
//  ActionSheetTitle.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import Foundation

enum ActionSheetTitle {
    case edit
    case exit
    case changeAdmin
    case delete
    
    var localized: String {
        switch self {
        case .edit:
            "PlaygroundEdit".localized()
        case .exit:
            "PlaygroundExit".localized()
        case .changeAdmin:
            "PlaygroundChangeAdmin".localized()
        case .delete:
            "PlaygroundDelete".localized()
        }
    }
}
