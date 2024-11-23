//
//  DMChattingViewController.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/12/24.
//

import UIKit
import PhotosUI

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
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(textFieldBackground.snp.top)
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
        
        let input = DMChattingViewModel.Input(
            viewWillAppearTrigger: viewdidLoadTrigger,
            sendBtnTapped: sendButton.rx.tap.asObservable(),
            plusBtnTapped: plusButton.rx.tap.asObservable(),
            chatBarText: chatTextField.rx.text.orEmpty.asObservable())
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
        
        output.scrollToDown
            .drive { [weak self] _ in
                guard let self else { return }
                let indexPath = IndexPath(
                    row: dmChattingTableView.numberOfRows(inSection: 0) - 1,
                    section: 0
                )
                
                if indexPath.row >= 0 {
                    dmChattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                }
            }
            .disposed(by: disposeBag)
        
        output.removeChattingBarText
            .drive { [weak self] _ in
                guard let self else { return }
                chatTextField.text = ""
            }
            .disposed(by: disposeBag)
        
        output.plusBtnTapped
            .drive { [weak self] _ in
                guard let self else { return }
                showPickerView()
            }
            .disposed(by: disposeBag)
    }
}

extension DMChattingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let image = image as? UIImage {
                // 선택된 이미지를 ViewModel에 전달
//                self?.viewModel.selectedImage.accept(image)
            }
        }
    }
    
    private func showPickerView() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .any(of: [.screenshots, .images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
}
