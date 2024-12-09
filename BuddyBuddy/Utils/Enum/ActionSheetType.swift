//
//  ActionSheetType.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import Foundation

enum ActionSheetType: CaseIterable {
    case edit
    case exit
    case changeAdmin
    case delete
    case cancel
    
    var title: String {
        switch self {
        case .edit:
            "PlaygroundEdit".localized()
        case .exit:
            "PlaygroundExit".localized()
        case .changeAdmin:
            "PlaygroundChangeAdmin".localized()
        case .delete:
            "PlaygroundDelete".localized()
        case .cancel:
            "Cancel".localized()
        }
    }
}
