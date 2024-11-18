//
//  KeyChainProtocol.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/17/24.
//

import Foundation

struct RouterFactory {
    let keyChain: KeyChainProtocol
}

protocol KeyChainProtocol: Sendable {
    func saveAccessToken(_ token: String)
    func saveRefreshToken(_ token: String)
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func deleteAccessToken()
    func deleteRefreshToken()
}
