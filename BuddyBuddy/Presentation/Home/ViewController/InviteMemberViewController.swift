//
//  InviteMemberViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class InviteMemberViewController: BaseViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: InviteMemberViewModel
    
    private let topView: ModalNavigationView
    = ModalNavigationView(title: "InviteMember".localized())
    private let emailTextField: TitledTextField = TitledTextField(
        title: "Email".localized(),
        placeholder: "InvitePlaceholder".localized()
    )
    
    init(vm: InviteMemberViewModel) {
        self.vm = vm
        
        super.init()
    }
    
    override func bind() {
        let input = InviteMemberViewModel.Input(backBtnTapped: topView.backBtn.rx.tap.map { () })
        let output = vm.transform(input: input)        
    }
    
    override func setHierarchy() {
        [topView, emailTextField].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(54)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(76)
        }
    }
    
    override func setView() {
        super.setView()
        
        view.backgroundColor = .gray2
    }
}
