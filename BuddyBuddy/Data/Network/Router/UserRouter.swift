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
    case appleLogin(query: AppleLoginQuery)
    case emailLogin(query: LoginQuery)
}

extension UserRouter: TargetType {
    var baseURL: String {
        return APIKey.baseURL + "/v1"
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .deviceToken, .appleLogin, .emailLogin:
            return .post
        case .myProfile, .userProfileImage, .userProfile:
            return .get
        case .editMyProfile, .editMyProfileImage:
            return .put
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
        case .appleLogin:
            return "/users/login/apple"
        case .emailLogin:
            return "/users/login"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .signIn, .deviceToken, .appleLogin, .emailLogin:
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
        case .appleLogin(let query):
            return encodingJSON(query)
        case .emailLogin(let query):
            return encodingJSON(query)
        default:
            return nil
        }
    }
    
    private func encodingJSON<T: Encodable>(_ value: T) -> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(value)
        } catch {
            return nil
        }
    }
}
