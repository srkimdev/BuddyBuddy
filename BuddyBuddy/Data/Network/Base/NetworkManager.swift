//
//  NetworkManager.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let logger = NetworkLogger()
        return Session(
            configuration: configuration,
            eventMonitors: [logger]
        )
    }()
    
    private init() { }
    
    func callRequest<T: Decodable>(router: APIRouter, responseType: T.Type) -> Single<Result<T, Error>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try router.asURLRequest()
                print(request)
                NetworkManager.session.request(request)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: responseType.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer(.success(.success(value)))
                        case .failure(let error):
                            observer(.success(.failure(error)))
                        }
                    }
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
}

extension NetworkManager {
    func accessTokenRefresh(completionHandler: @escaping (Result<AccessToken, Error>) -> Void) {
        do {
            let request = try APIRouter.accessTokenRefresh.asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: AccessTokenDTO.self) { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(.success(value.toDomain()))
                    case .failure(let error):
                        print(error)
                    }
                }
            
        } catch {
            print(error)
        }
    }
}
