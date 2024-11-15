//
//  DMRouter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/15/24.
//

import Foundation

import Alamofire

enum DMRouter: TargetType {
    case dmList(playgroundID: String)
    
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .dmList(let playgroundID):
            return "workspaces/\(playgroundID)/dms"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dmList:
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
        case .dmList:
            let header = [
                Header.authorization.rawValue: KeyChainManager.shard.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
            print(header)
            return header
        }
    }
}
