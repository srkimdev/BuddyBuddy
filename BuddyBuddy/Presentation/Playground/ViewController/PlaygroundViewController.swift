//
//  PlaygroundViewController.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/29/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class PlaygroundViewController: BaseViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    private let vm: PlaygroundViewModel
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Playground".localized()
        view.font = .title1
        return view
    }()
    private let playgroundTableView: UITableView = {
        let view = UITableView()
        view.register(
            PlaygroundTableViewCell.self,
            forCellReuseIdentifier: PlaygroundTableViewCell.identifier
        )
        view.backgroundColor = .clear
        view.rowHeight = 72
        view.separatorStyle = .none
        return view
    }()
    private let bottomView: PlaygroundBottomView = PlaygroundBottomView()
    private let actionSheet: UIAlertController = UIAlertController(
        title: nil,
        message: nil,
        preferredStyle: .actionSheet
    )
    
    init(vm: PlaygroundViewModel) {
        self.vm = vm
        super.init()
    }
    
    override func bind() {
        let actionSheetItemTapped = PublishRelay<ActionSheetType>()
        let moreBtnTapped = PublishRelay<String>()
        let input = PlaygroundViewModel.Input(
            viewWillAppearTrigger: rx.viewWillAppear,
            selectedPlayground: playgroundTableView.rx.modelSelected(Workspace.self).asObservable(),
            moreBtnTapped: moreBtnTapped.asObservable(),
            actionSheetItemTapped: actionSheetItemTapped.asObservable(),
            addBtnTapped: bottomView.addButton.rx.tap.asObservable()
        )
        let output = vm.transform(input: input)
        
        output.playgroundList
            .drive(playgroundTableView.rx.items(
                cellIdentifier: PlaygroundTableViewCell.identifier,
                cellType: PlaygroundTableViewCell.self
            )) { _, value, cell in
                cell.configureCell(value)
            }
            .disposed(by: disposeBag)
        
        output.showActionSheet
            .drive(with: self) { owner, _ in
                owner.setActionSheet(with: actionSheetItemTapped)
            }
            .disposed(by: disposeBag)
        
        // TODO: Alert 추가
    }
    
    override func setView() {
        view.backgroundColor = .gray3
    }
    
    override func setHierarchy() {
        [titleLabel, playgroundTableView, bottomView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(8)
            make.leading.equalToSuperview().inset(16
            )
        }
        playgroundTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.horizontalEdges.equalToSuperview()
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(playgroundTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeArea)
            make.height.equalTo(82)
        }
    }
    
    func setActionSheet(with relay: PublishRelay<ActionSheetType>) {
        for type in ActionSheetType.allCases {
            var title = ""
            switch type {
            case .edit:
                title = ActionSheetTitle.edit.localized
            case .exit:
                title = ActionSheetTitle.exit.localized
            case .changeAdmin:
                title = ActionSheetTitle.changeAdmin.localized
            case .delete:
                title = ActionSheetTitle.delete.localized
            }
            
            let action = UIAlertAction(
                title: title,
                style: .default
            ) { _ in
                relay.accept(type)
            }
            
            actionSheet.addAction(action)
        }
        
        DispatchQueue.main.async {
            self.present(self.actionSheet, animated: true)
        }
    }
}
