//
//  DMChattingViewController.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import UIKit

import RxSwift
import SnapKit

final class DMChattingViewController: BaseNavigationViewController {
    private let disposeBag = DisposeBag()
    private let vm: DMChattingViewModel
    
    private let dmChattingTableView: UITableView = {
        let view = UITableView()
        view.register(
            DMChattingTableViewCell.self,
            forCellReuseIdentifier: DMChattingTableViewCell.identifier
        )
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        return view
    }()
    
    init(vm: DMChattingViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setHierarchy() {
        view.addSubview(dmChattingTableView)
    }
    
    override func setConstraints() {
        dmChattingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        let viewdidLoadTrigger = Observable.just(())
        
        let input = DMChattingViewModel.Input(viewWillAppearTrigger: viewdidLoadTrigger)
        let output = vm.transform(input: input)
        
        output.updateDMListTableView
            .drive(
                dmChattingTableView.rx.items(
                    cellIdentifier: DMChattingTableViewCell.identifier,
                    cellType: DMChattingTableViewCell.self
                )
            ) { (_, element, cell) in
                cell.designCell(element)
            }
            .disposed(by: disposeBag)
    }
    
}
