//
//  UserRouter.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

import Alamofire

enum UserRouter {
    case signIn
    case deviceToken(query: String)
    case myProfile
    case editMyProfile
    case editMyProfileImage(query: Data)
    case userProfile(query: String)
    case userProfileImage(path: String)
}

extension UserRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1"
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .deviceToken:
            return .post
        case .myProfile, .userProfileImage:
            return .get
        case .editMyProfile, .editMyProfileImage:
            return .put
        case .userProfile:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/users/join"
        case .deviceToken:
            return "/users/deviceToken"
        case .myProfile, .editMyProfile:
            return "/users/me"
        case .editMyProfileImage:
            return "/users/me/image"
        case .userProfile(let userID):
            return "/users/\(userID)"
        case .userProfileImage(let path):
            return path
        }
    }
    
    var header: [String: String] {
        switch self {
        case .signIn, .deviceToken:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.Key.rawValue: APIKey.Key
            ]
        case .myProfile, .userProfile, .editMyProfile, .editMyProfileImage:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.authorization.rawValue: KeyChainManager.shared.getRefreshToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        case .userProfileImage:
            return [
                Header.contentType.rawValue: Header.multipart.rawValue,
                Header.authorization.rawValue: KeyChainManager.shared.getRefreshToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
        }
    }
    
    var parameters: String? {
        switch self {
        case .deviceToken(let query):
            return query
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .editMyProfileImage(let query):
            return query
        default:
            return nil
        }
    }
}
