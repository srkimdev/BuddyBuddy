//
//  TargetType.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)!
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw AFError.invalidURL(url: baseURL + path)
        }
        var request = try URLRequest(url: url, method: method)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }
}

