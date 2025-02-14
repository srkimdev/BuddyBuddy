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
                case .failure(_):
                    return Single.just(nil)
                }
            }
    }
    
    func loginWithApple(_ user: AppleUser) -> Single<Result<Bool, Error>> {
        let query = AppleLoginQuery(
            idToken: String(data: user.token ?? Data(), encoding: .utf8) ?? "",
            nickname: user.nickname,
            deviceToken: ""
        )
        return repository.loginWithApple(query: query)
    }
    
    func loginWithEmail() -> Single<Result<Bool, Error>> {
        return repository.loginWithEmail()
    }
}
