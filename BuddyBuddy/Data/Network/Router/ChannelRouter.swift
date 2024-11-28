//
//  ChannelRouter.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import Alamofire

enum ChannelRouter {
    case myChannelList(playgroundID: String)
    case unreadCount(playgroundID: String, channelID: String, after: Date?)
    case createChannel(request: AddChannelReqeustDTO)
}

extension ChannelRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .myChannelList, .unreadCount:
            return .get
        case .createChannel:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .myChannelList(let playgroundID):
            return "workspaces/\(playgroundID)/my-channels"
        case .unreadCount(let playgroundID, let channelID, _):
            return "workspaces/\(playgroundID)/channels/\(channelID)/unreads"
        case .createChannel:
            return "workspaces/\(UserDefaultsManager.playgroundID)/channels"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .myChannelList, .unreadCount:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .createChannel:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key,
                Header.contentType.rawValue: Header.json.rawValue
            ]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .myChannelList, .createChannel:
            return nil
        case .unreadCount(_, _, let after):
            guard let after else { return nil }
            let afterValue = after.toString(format: .defaultDate)
            return [URLQueryItem(name: "after", value: afterValue)]
        }
    }
    
    var body: Data? {
        switch self {
        case .createChannel(let request):
            let encoder = JSONEncoder()
            do {
                return try encoder.encode(request)
            } catch {
                print(error)
                return nil
            }
        default: 
            return nil
        }
    }
}
