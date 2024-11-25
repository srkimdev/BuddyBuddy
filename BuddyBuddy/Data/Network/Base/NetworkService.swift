//
//  NetworkManager.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import Foundation

import UIKit
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
    
    func downloadImage(router: TargetType) -> Single<Result<Data?, Error>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try router.asURLRequest()
                NetworkService.session.download(request)
                    .validate(statusCode: 200..<300)
                    .responseData { response in
                        switch response.result {
                        case .success(let value):
                            observer(.success(.success(value)))
                        case .failure(_):
                            observer(.success(.success(nil)))
                        }
                    }
            } catch {
                print(error)
            }
            
            return Disposables.create()
        }
    }
}

extension NetworkService {
    func callMultiPart<T: Decodable>(
        router: TargetType,
        responseType: T.Type,
        content: String
    ) -> Single<Result<T, Error>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try router.asURLRequest()
                NetworkService.session.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(
                            content.data(using: .utf8)!,
                            withName: "content"
                        )
                        
                        guard let image = UIImage(named: "spinner") else { return }
                        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                            return
                        }
                        let fileDataArray: [Data] = [imageData]
                        
                        for (index, data) in fileDataArray.enumerated() {
                            multipartFormData.append(data,
                                                     withName: "files",
                                                     fileName: "file\(index + 1).jpg",
                                                     mimeType: "image/jpeg"
                            )
                        }
                    }, 
                    with: request,
                    interceptor: AuthIntercepter()
                )
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(.success(value)))
                    case .failure(let error):
                        print(error, "here")
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
