//
//  AppleLoginQuery.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/2/24.
//

import Foundation

struct AppleLoginQuery: Encodable {
    let idToken: String
    let nickname: String?
    let deviceToken: String?
}
