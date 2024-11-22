//
//  AuthIntercepter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation

import Alamofire

final class AuthIntercepter: RequestInterceptor {
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        urlRequest.setValue(
            KeyChainManager.shared.getAccessToken(),
            forHTTPHeaderField: "accept"
        )
        completion(.success(urlRequest))
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse, 
                response.statusCode == 400 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        print(response.statusCode, "statuscode")
        
//        do {
//            let request = try LogInRouter.accessTokenRefresh.asURLRequest()
//            session.request(request)
//                .responseDecodable(of: AccessTokenDTO.self) { response in
//                    switch response.result {
//                    case .success(let value):
//                        KeyChainManager.shared.saveAccessToken(value.accessToken)
//                        completion(.retry)
//                    case .failure(let error):
//                        completion(.doNotRetryWithError(error))
//                    }
//                }
//        } catch {
//            print(error)
//        }
    }
}
