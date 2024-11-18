//
//  KeyChainManager.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation
import Security

final class KeyChainManager: KeyChainProtocol {
    static let shared = KeyChainManager()
    private init() { }
    
    // save accessToken
    func saveAccessToken(_ token: String) {
        guard let tokenData = token.data(using: .utf8) else { return }
        deleteAccessToken()

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecValueData as String: tokenData
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    // save refreshToken
    func saveRefreshToken(_ token: String) {
        guard let tokenData = token.data(using: .utf8) else { return }
        deleteRefreshToken()

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refreshToken",
            kSecValueData as String: tokenData
        ]

        SecItemAdd(query as CFDictionary, nil)
    }
    
    // load accessToken
    func getAccessToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data else {
            return nil
        }

        return String(
            data: data,
            encoding: .utf8
        )
    }
    
    // load refreshToken
    func getRefreshToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refreshToken",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, 
                let data = item as? Data else {
            return nil
        }

        return String(
            data: data,
            encoding: .utf8
        )
    }

    // delete accessToken
    func deleteAccessToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken"
        ]

        SecItemDelete(query as CFDictionary)
    }
    
    // delete refreshToken
    func deleteRefreshToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refreshToken"
        ]

        SecItemDelete(query as CFDictionary)
    }
}
