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
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        return view
    }()
    private let textFieldBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .gray3
        view.layer.cornerRadius = 8
        return view
    }()
    private let chatTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "메시지를 입력하세요"
        return view
    }()
    private let plusButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(pointSize: 16)
        
        config.preferredSymbolConfigurationForImage = imgConfig
        config.image = UIImage(systemName: "plus")
        config.baseForegroundColor = .black
        config.contentInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        view.configuration = config
        view.backgroundColor = .gray3
        
        return view
    }()
    private let sendButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(pointSize: 16)
        
        config.preferredSymbolConfigurationForImage = imgConfig
        config.image = UIImage(systemName: "paperplane")
        config.baseForegroundColor = .black
        config.contentInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        view.configuration = config
        view.backgroundColor = .gray3
        
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
        view.addSubview(textFieldBackground)
        [chatTextField, plusButton, sendButton].forEach {
            textFieldBackground.addSubview($0)
        }
    }
    
    override func setConstraints() {
        dmChattingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        textFieldBackground.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(textFieldBackground.snp.leading).offset(8)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(44)
        }
        chatTextField.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing)
            make.verticalEdges.equalToSuperview()
            make.trailing.equalTo(sendButton.snp.leading)
        }
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(44)
        }
    }
    
    override func bind() {
        let viewdidLoadTrigger = Observable.just(())
        
        let input = DMChattingViewModel.Input(viewWillAppearTrigger: viewdidLoadTrigger, sendBtnTapped: chatTextField.rx.text.orEmpty.asObservable())
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
