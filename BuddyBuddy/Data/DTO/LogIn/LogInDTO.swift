//
//  LogInDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation

struct LogInDTO: Decodable {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
    let phone: String
    let provider: String?
    let createdAt: String
    let token: TokenDTO
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email
        case nickname
        case profileImage
        case phone
        case provider
        case createdAt
        case token
    }
}

struct TokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
