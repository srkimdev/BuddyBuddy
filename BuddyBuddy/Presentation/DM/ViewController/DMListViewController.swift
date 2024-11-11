//
//  DMViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxSwift
import SnapKit

final class DMListViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    private let vm: DMViewModel
    
    private let dmListTableView: UITableView = {
        let view = UITableView()
        view.register(DMListTableViewCell.self, forCellReuseIdentifier: DMListTableViewCell.identifier)
        view.rowHeight = 70
        return view
    }()
    
    init(vm: DMViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setHierarchy() {
        view.addSubview(dmListTableView)
    }
    
    override func setConstraints() {
        dmListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        let viewdidLoadTrigger = Observable.just(())
        
        let input = DMViewModel.Input(viewWillAppearTrigger: viewdidLoadTrigger)
        let output = vm.transform(input: input)
        
        output.updateDMListTableView
            .drive(
                dmListTableView.rx.items(
                    cellIdentifier: DMListTableViewCell.identifier,
                    cellType: DMListTableViewCell.self
                )
            ) { (row, element, cell) in
                cell.designCell(element)
            }
            .disposed(by: disposeBag)
            
    }
}
