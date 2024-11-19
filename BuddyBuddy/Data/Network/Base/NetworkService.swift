//
//  NetworkManager.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import Alamofire
import RxSwift

final class NetworkService: NetworkProtocol {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let logger = NetworkLogger()
        return Session(
            configuration: configuration,
            eventMonitors: [logger]
        )
    }()
    
    func callRequest<T: Decodable>(
        router: TargetType,
        responseType: T.Type
    ) -> Single<Result<T, Error>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try router.asURLRequest()
                NetworkService.session.request(
                    request,
                    interceptor: AuthIntercepter()
                )
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
