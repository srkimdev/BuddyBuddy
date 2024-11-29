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
    case unreadCount(playgroundID: String, channelID: String, after: String?)
    case createChannel(request: AddChannelReqeustDTO)
    case fetchChannelChat(query: ChannelChatQuery)
    case specificChannel(playgroundID: String, channelID: String)
    case changeChannelAdmin(playgroundID: String, channelID: String, ownerID: String)
    case deleteChannel(playgroundID: String, channelID: String)
    case exitChannel(playgroundID: String, channelID: String)
}

extension ChannelRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .myChannelList, .unreadCount, .fetchChannelChat, .specificChannel, .exitChannel:
            return .get
        case .changeChannelAdmin:
            return .put
        case .deleteChannel:
            return .delete
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
        case .fetchChannelChat(let query):
            return "workspaces/\(query.playgroundID)/channels/\(query.channelID)/chats"
        case .specificChannel(let playgroundID, let channelID):
            return "workspaces/\(playgroundID)/channels/\(channelID)"
        case .changeChannelAdmin(let playgroundID, let channelID, _):
            return "workspaces/\(playgroundID)/channels/\(channelID)/transfer/ownership"
        case .deleteChannel(let playgroundID, let channelID):
            return "workspaces/\(playgroundID)/channels/\(channelID)"
        case .exitChannel(let playgroundID, let channelID):
            return "workspaces/\(playgroundID)/channels/\(channelID)/exit"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .myChannelList, .unreadCount, .fetchChannelChat,
                .specificChannel, .exitChannel, .deleteChannel:
            return [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .createChannel, .changeChannelAdmin:
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
        case .myChannelList, .specificChannel, .createChannel,
                .changeChannelAdmin, .deleteChannel, .exitChannel:
            return nil
        case .unreadCount(_, _, let after):
            guard let after else { return nil }
            return [URLQueryItem(name: "after", value: after)]
        case .fetchChannelChat(let query):
            return [URLQueryItem(name: "cursor_date", value: query.cursorDate)]
        }
    }
    
    var body: Data? {
        switch self {
        case .changeChannelAdmin(_, _, let ownerID):
            let query = ChangeChannelQuery(ownerID: ownerID)
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
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
