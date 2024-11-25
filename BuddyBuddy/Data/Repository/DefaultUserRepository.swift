//
//  DefaultUserRepository.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DefaultUserRepository: UserRepositoryInterface {
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func checkMyProfile() -> Single<Result<MyProfile, Error>> {
        let router = UserRouter.myProfile
        return networkService.callRequest(
            router: router,
            responseType: ProfileDTO.self
        )
        .map { result in
            switch result {
            case .success(let value):
                return .success(value.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func checkUserProfile(userID: String) -> Single<Result<UserProfile, Error>> {
        let router = UserRouter.userProfile(query: userID)
        return networkService.callRequest(
            router: router,
            responseType: UserProfileDTO.self
        )
        .map { result in
            switch result {
            case .success(let value):
                return .success(value.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func getUserProfileImage(imagePath: String?) -> Single<Result<Data?, Error>> {
        let router = UserRouter.userProfileImage(path: imagePath ?? "")
        
        return networkService.downloadImage(router: router)
            .map { result in
                switch result {
                case .success(let data):
                    return .success(data)
                case .failure(let error):
                    return .failure(error)
                }
            }
    }
}
