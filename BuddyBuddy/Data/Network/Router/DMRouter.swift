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
    case dmChat(playgroundID: String, roomID: String, cursorDate: String)
    
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .dmList(let playgroundID):
            return "workspaces/\(playgroundID)/dms"
        case .dmChat(let playgroundID, let roomID, _):
            return "workspaces/\(playgroundID)/dms/\(roomID)/chats"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dmList:
            return .get
        case .dmChat:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .dmChat(_, _, let cursorDate):
            return [URLQueryItem(name: "cursor_date", value: cursorDate)]
        
        default:
            return nil
        }
    }
    
    var body: Data? {
        return nil
    }

    var header: [String: String] {
        switch self {
        case .dmList:
            [
                Header.authorization.rawValue: KeyChainManager.shard.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .dmChat:
            [
                Header.authorization.rawValue: KeyChainManager.shard.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
}
