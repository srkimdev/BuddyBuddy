//
//  ChannelRouter.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

import Alamofire

enum ChannelRouter {
    case fetchMyChannelList(playgroundID: String)
    case countUnreads(playgroundID: String, channelID: String, after: Date? = nil)
}

extension ChannelRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMyChannelList, .countUnreads:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchMyChannelList(let playgroundID):
            return "/workspaces/\(playgroundID)/my-channels"
        case .countUnreads(let playgroundID, let channelID, _):
            return "/workspaces/\(playgroundID)/channels/\(channelID)/unreads"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .fetchMyChannelList, .countUnreads:
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
        case .fetchMyChannelList:
            return nil
        case .countUnreads(_, _, let after):
            guard let after else { return nil }
            let afterValue = after.toString(format: .defaultDate)
            return [URLQueryItem(name: "after", value: afterValue)]
        }
    }
    
    var body: Data? {
        return nil
    }
}
