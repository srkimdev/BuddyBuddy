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
    private let vm: DMListViewModel
    
    private let dmListTableView: UITableView = {
        let view = UITableView()
        view.register(DMListTableViewCell.self, forCellReuseIdentifier: DMListTableViewCell.identifier)
        view.rowHeight = 70
        return view
    }()
    private let noChatListImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "spinner")
        return view
    }()
    private let noChatListLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "대화 목록이 없어요\n지금 바로 대화를 시작해보세요!"
        return view
    }()
    
    init(vm: DMListViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setHierarchy() {
        view.addSubview(dmListTableView)
        view.addSubview(noChatListImage)
        view.addSubview(noChatListLabel)
    }
    
    override func setConstraints() {
        dmListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        noChatListImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-view.frame.height * 0.05)
        }
        noChatListLabel.snp.makeConstraints { make in
            make.top.equalTo(noChatListImage.snp.bottom)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bind() {
        let viewdidLoadTrigger = Observable.just(())
        
        let input = DMListViewModel.Input(viewWillAppearTrigger: viewdidLoadTrigger)
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
