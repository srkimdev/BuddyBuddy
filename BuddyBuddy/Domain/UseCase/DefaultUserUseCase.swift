//
//  DefaultUserUseCase.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DefaultUserUseCase: UserUseCaseInterface {
    @Dependency(UserRepositoryInterface.self) private var repository
    
    func checkMyProfile() -> Single<Result<MyProfile, Error>> {
        return repository.checkMyProfile()
    }
    
    func checkUserProfile(userID: String) -> Single<Result<UserProfile, Error>> {
        return repository.checkUserProfile(userID: userID)
    }
    
    func getUserProfileImage(imagePath: String?) -> Single<Data?> {
        return repository.getUserProfileImage(imagePath: imagePath)
            .flatMap { result in
                switch result {
                case .success(let data):
                    return Single.just(data)
                case .failure(let error):
                    return Single.just(nil)
                }
            }
    }
}
