//
//  HomeViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxSwift

final class HomeViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: HomeViewModel
    
    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just(())
            .flatMap {
                let login = LoginQuery(email: "compose@coffee.com", password: "1q2w3e4rQ!")
                return NetworkManager.shared.callRequest(router: APIRouter.login(query: login), responseType: LogInDTO.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let value):
                    print("토큰 저장")
                    KeyChainManager.shard.saveAccessToken(value.token.accessToken)
                    KeyChainManager.shard.saveRefreshToken(value.token.refreshToken)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
