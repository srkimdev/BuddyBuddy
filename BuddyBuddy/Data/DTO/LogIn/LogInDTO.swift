//
//  LogInDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation

struct LogInDTO: Decodable {
    let user_id: String
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String
    let provider: String?
    let createdAt: String
    let token: TokenDTO
}

struct TokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
