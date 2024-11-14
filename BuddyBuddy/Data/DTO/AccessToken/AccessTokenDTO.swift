//
//  AccessTokenDTO.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation

struct AccessTokenDTO: Decodable {
    let accessToken: String
}

extension AccessTokenDTO {
    func toDomain() -> AccessToken {
        return AccessToken(accessToken: accessToken)
    }
}
