//
//  LoginType.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/1/24.
//

import Foundation

enum LoginType {
    case apple
    case kakao
    
    var toImageName: String {
        switch self {
        case .apple:
            return "AppleLogin"
        case .kakao:
            return "KakaoLogin"
        }
    }
}
