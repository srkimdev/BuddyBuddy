//
//  AuthIntercepter.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/13/24.
//

import Foundation

import Alamofire

final class AuthIntercepter: RequestInterceptor{
    @Dependency(NetworkProtocol.self) private var service
    @Dependency(KeyChainProtocol.self) private var keyChain
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        urlRequest.setValue(
            keyChain.getAccessToken(),
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
                response.statusCode == 419 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        service.accessTokenRefresh { response in
            switch response {
            case .success(let value):
                self.keyChain.saveAccessToken(value.accessToken)
                completion(.retry)
                print("토큰 갱신 성공")
            case .failure:
                completion(.doNotRetryWithError(error))
                // 로그인 화면으로 이동
            }
        }
    }
}
