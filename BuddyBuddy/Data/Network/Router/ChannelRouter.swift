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
    case fetchChannelChat(query: ChannelChatQuery)
    case specificChannel(playgroundID: String, channelId: String)
}

extension ChannelRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .myChannelList, .unreadCount, .fetchChannelChat, .specificChannel:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .myChannelList(let playgroundID):
            return "workspaces/\(playgroundID)/my-channels"
        case .unreadCount(let playgroundID, let channelID, _):
            return "workspaces/\(playgroundID)/channels/\(channelID)/unreads"
        case .fetchChannelChat(let query):
            return "workspaces/\(query.playgroundID)/channels/\(query.channelID)/chats"
        case .specificChannel(let playgroundID, let channelID):
            return "workspaces/\(playgroundID)/channels/\(channelID)"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .myChannelList, .unreadCount, .fetchChannelChat, .specificChannel:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .myChannelList, .specificChannel:
            return nil
        case .unreadCount(_, _, let after):
            guard let after else { return nil }
            let afterValue = after.toString(format: .defaultDate)
            return [URLQueryItem(name: "after", value: afterValue)]
        case .fetchChannelChat(let query):
            return [URLQueryItem(name: "cursor_date", value: query.cursorDate)]
        }
    }
    
    var body: Data? {
        return nil
    }
}
