//
//  ProfileViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ProfileViewController: BaseViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: ProfileViewModel
    
    private let profileImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "person")
        return view
    }()
    private let profileBottmView: ProfileBottomView = ProfileBottomView()
    
    init(vm: ProfileViewModel) {
        self.vm = vm
        
        super.init()
    }
    
    override func bind() {
        
    }
    
    override func setHierarchy() {
        [profileImgView, profileBottmView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileImgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(profileBottmView.snp.top)
        }
        
        profileBottmView.snp.makeConstraints { make in
            make.top.equalTo(profileImgView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        profileBottmView.setProfileView(
            name: "함지수",
            email: "compose@coffee.com"
        )
    }
}
