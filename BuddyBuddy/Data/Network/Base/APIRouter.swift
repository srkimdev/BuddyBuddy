//
//  APIRouter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire

enum APIRouter: TargetType {
    case dmList(workspaceID: String)
    
    var baseURL: String {
        return "http://" + APIKey.baseURL + "/v1/"
    }
    
    var path: String {
        switch self {
        case .dmList(let workspaceID):
            return "workspaces/\(workspaceID)/dms"
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
            return [
                Header.authorization.rawValue: "",
                Header.contentType.rawValue: Header.json.rawValue,
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
}


