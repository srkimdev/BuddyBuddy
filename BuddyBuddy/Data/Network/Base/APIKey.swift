//
//  APIKey.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

struct APIKey {
    static let baseURL = 
    (Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? "") +
    ":" +
    (Bundle.main.object(forInfoDictionaryKey: "Port") as? String ?? "")
    static let Key = Bundle.main.object(forInfoDictionaryKey: "Key") as? String ?? ""
}
