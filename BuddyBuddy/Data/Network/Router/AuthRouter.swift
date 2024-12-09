//
//  AuthRouter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire

enum AuthRouter {
    case accessTokenRefresh
}

extension AuthRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .accessTokenRefresh:
            return "auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .accessTokenRefresh:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }

    var header: [String: String] {
        switch self {
        case .accessTokenRefresh:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.refresh.rawValue: KeyChainManager.shared.getRefreshToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
}
