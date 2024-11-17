//
//  NetworkLogger.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/15/24.
//

import Foundation

import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "NetworkLogger")
    
    func requestDidFinish(_ request: Request) {
        print("—————————— 🛜 Request 🛜 ——————————")
        print(request.description)
        
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
            + "Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
        print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<
        Value,
        AFError
        >
    ) {
        print("—————————— ✅ Response ✅ ——————————")
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "Result: " + "\(response.result)" + "\n"
            + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "Data: \(response.data?.toPrettyPrintedString ?? "")"
        )
        print("—————————————————————————————————————")
    }
    
    func requestDidCancel(_ request: Request) {
        print("————— 🚨 Request Fail 🚨 —————")
    }
    
    func requestIsRetrying(_ request: Request) {
        print("————— 💫 Request Retry 💫 —————")
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
              ),
              let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
              ) else { return nil }
        return prettyPrintedString as String
    }
}
