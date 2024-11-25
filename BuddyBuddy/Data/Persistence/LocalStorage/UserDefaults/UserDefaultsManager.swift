//
//  UserDefaultsManager.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/25/24.
//

import Foundation

enum UserDefaultsManager {
    enum Key: String {
        case playgroundID
        case userID
    }
    
    @BaseUserDefaults(key: Key.playgroundID.rawValue, defaultValue: "playgroundID")
    static var playgroundID
    
    @BaseUserDefaults(key: Key.userID.rawValue, defaultValue: "userID")
    static var userID
}
