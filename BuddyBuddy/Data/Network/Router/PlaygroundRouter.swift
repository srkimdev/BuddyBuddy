//
//  PlaygroundRouter.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import Alamofire

enum PlaygroundRouter {
    case search(query: SearchQuery)
    case specificPlaygroundInfo
}

extension PlaygroundRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .search(_), .specificPlaygroundInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search(let query):
            return "workspaces/\(query.playgroundID)/search"
        case .specificPlaygroundInfo:
            return "workspaces/\(UserDefaultsManager.playgroundID)"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .search(_), .specificPlaygroundInfo:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.authorization.rawValue: KeyChainManager.shared.getRefreshToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query):
            return [URLQueryItem(name: "keyword", value: query.keyword)]
        case .specificPlaygroundInfo:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .search(_), .specificPlaygroundInfo:
            return nil
        }
    }
}
