//
//  BaseUserDefaults.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/25/24.
//

import Foundation

@propertyWrapper
struct BaseUserDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
