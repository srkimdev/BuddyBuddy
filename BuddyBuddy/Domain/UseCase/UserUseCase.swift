//
//  UserUseCase.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/21/24.
//

import Foundation

import RxCocoa
import RxSwift

final class UserUseCase: UserUseCaseInterface {
    @Dependency(UserRepositoryInterface.self) private var repository
    
    func checkMyProfile() -> Single<Result<MyProfile, Error>> {
        return repository.checkMyProfile()
    }
    func checkUserProfile(userID: String) -> Single<Result<UserProfile, Error>> {
        return repository.checkUserProfile(userID: userID)
    }
}
