//
//  ChannelAdminViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ChannelAdminViewController: BaseViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: ChangeAdminViewModel
    
    private let topView: ModalNavigationView = ModalNavigationView(
        title: "ChangeChannelAdmin".localized()
    )
    private let userTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(
            ChannelAdminTableViewCell.self,
            forCellReuseIdentifier: ChannelAdminTableViewCell.identifier
        )
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    init(vm: ChangeAdminViewModel) {
        self.vm = vm
        
        super.init()
    }
    
    override func bind() {
        let input = ChangeAdminViewModel.Input(backBtnTapped: topView.backBtn.rx.tap.map { () })
        let output = vm.transform(input: input)
    }
    
    override func setHierarchy() {
        [topView, userTableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(54)
        }
        userTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
}
