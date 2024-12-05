//
//  AuthViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class AuthViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()

    private let vm: AuthViewModel
    
    private let introImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let appleButton: LoginButton = LoginButton(loginType: .apple)
    private let kakaoButton: LoginButton = LoginButton(loginType: .kakao)
    private let emailButton = RoundedButton(
        title: "이메일로 계속하기",
        bgColor: .secondary,
        txtColor: .white,
        btnType: .generalBtn
    )
    
    init(vm: AuthViewModel) {
        self.vm = vm
        
    }
    
    override func bind() { 
        let input = AuthViewModel.Input(
            appleLoginTapped: appleButton.rx.tap.map { () },
            kakaoLoginTapped: kakaoButton.rx.tap.map { () },
            emailLoginTapped: emailButton.rx.tap.map { () }
        )
        let output = vm.transform(input: input)
    }
    
    override func setHierarchy() { 
        [introImageView, appleButton, kakaoButton, emailButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() { 
        introImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(introImageView.snp.width)
        }
        appleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(44)
            make.bottom.equalTo(kakaoButton.snp.top).offset(-16)
        }
        kakaoButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(44)
            make.bottom.equalTo(emailButton.snp.top).offset(-16)
        }
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(60)
        }
    }
}
