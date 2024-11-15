//
//  LogInRouter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire

enum LogInRouter: TargetType {
    case login(query: LoginQuery)
    case accessTokenRefresh
    
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .accessTokenRefresh:
            return "auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
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
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
        default:
            return nil
        }
    }

    var header: [String: String] {
        switch self {
        case .accessTokenRefresh:
            return [
                Header.authorization.rawValue: KeyChainManager.shard.getRefreshToken() ?? "",
                Header.contentType.rawValue: Header.json.rawValue,
                Header.Key.rawValue: APIKey.Key
            ]
        case .login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
}
