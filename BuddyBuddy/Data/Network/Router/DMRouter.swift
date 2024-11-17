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
    case dmHistory(playgroundID: String, roomID: String, cursorDate: String)
    case dmUnRead(playgroundID: String, roomID: String, after: String)
    
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .dmList(let playgroundID):
            return "workspaces/\(playgroundID)/dms"
        case .dmHistory(let playgroundID, let roomID, _):
            return "workspaces/\(playgroundID)/dms/\(roomID)/chats"
        case .dmUnRead(let playgroundID, let roomID, _):
            return "workspaces/\(playgroundID)/dms/\(roomID)/unreads"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dmList:
            return .get
        case .dmHistory:
            return .get
        case .dmUnRead:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .dmHistory(_, _, let cursorDate):
            return [URLQueryItem(name: "cursor_date", value: cursorDate)]
        case .dmUnRead(_, _, let after):
            return [URLQueryItem(name: "after", value: after)]
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
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .dmHistory:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .dmUnRead:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
}
