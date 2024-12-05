//
//  AuthViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

final class AuthViewModel: NSObject, ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let coordinator: AuthCoordinator
    private let userUseCase: UserUseCaseInterface
    
    private let userInfoAboutApple = PublishRelay<AppleUser>()
    
    init(
        coordinator: AuthCoordinator,
        userUseCase: UserUseCaseInterface
    ) {
        self.coordinator = coordinator
        self.userUseCase = userUseCase
    }
    
    deinit {
        print("DEINIT")
    }
    
    struct Input {
        let appleLoginTapped: Observable<Void>
        let kakaoLoginTapped: Observable<Void>
        let emailLoginTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        input.appleLoginTapped
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.performAppleSignIn()
            }
            .withUnretained(self)
            .flatMap { (owner, user) in
                return owner.userUseCase.loginWithApple(user)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let isFinish):
                    print(isFinish)
                    if isFinish {
                        owner.coordinator.changeToHome()
                    } else {
                        print("Toast Message")
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.emailLoginTapped
            .withUnretained(self)
            .flatMap { (owner, _) in
                owner.userUseCase.loginWithEmail()
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let isLogined):
                    if isLogined {
                        owner.coordinator.changeToHome()
                    } else {
                        print("Toast Message")
                    }
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    private func performAppleSignIn() -> Observable<AppleUser> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.performRequests()
            
            userInfoAboutApple
                .subscribe(onNext: { user in
                    observer.onNext(user)
                    observer.onCompleted()
                })
                .disposed(by: disposeBag)
            
            return Disposables.create()
        }
    }
}

extension AuthViewModel: ASAuthorizationControllerDelegate {
    // 애플 로그인 성공
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let familyName = appleIDCredential.fullName?.familyName ?? ""
            let givenName = appleIDCredential.fullName?.givenName ?? ""
            let token = appleIDCredential.identityToken
            
            let user = AppleUser(
                nickname: familyName + givenName,
                token: token
            )
            
            userInfoAboutApple.accept(user)
        }
    }
    
    // 애플 로그인 Error
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: any Error
    ) {
        print("Error")
    }
}
