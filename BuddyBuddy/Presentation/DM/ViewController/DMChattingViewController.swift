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
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private let chatBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .gray3
        view.layer.cornerRadius = 8
        return view
    }()
    private let chatTextView: UITextView = {
        let view = UITextView()
//        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .gray3
//        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.textContainer.lineBreakMode = .byWordWrapping
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
        config.image = UIImage(named: "send")
        config.baseForegroundColor = .black
        config.contentInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        view.configuration = config
        view.backgroundColor = .clear
        
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
        view.addSubview(chatBarBackground)
        [plusButton, chatTextView, sendButton].forEach {
            chatBarBackground.addSubview($0)
        }
    }
    
    override func setConstraints() {
        dmChattingTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(chatBarBackground.snp.top).priority(.high)
        }
        chatBarBackground.snp.makeConstraints { make in
            make.top.equalTo(dmChattingTableView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(chatBarBackground.snp.leading).offset(8)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(44)
        }
        
        let height = chatTextView.font!.lineHeight + chatTextView.layoutMargins.top + chatTextView.layoutMargins.bottom
        chatTextView.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing)
            make.trailing.equalTo(sendButton.snp.leading)
            make.height.equalTo(height)
            make.verticalEdges.equalToSuperview().inset(8)
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
            chatBarText: chatTextView.rx.text.orEmpty.asObservable()
        )
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
                    dmChattingTableView.scrollToRow(
                        at: indexPath, at: .bottom,
                        animated: false
                    )
                }
            }
            .disposed(by: disposeBag)
        
        output.removeChattingBarText
            .drive { [weak self] _ in
                guard let self else { return }
                chatTextView.text = ""
            }
            .disposed(by: disposeBag)
        
        output.plusBtnTapped
            .drive { [weak self] _ in
                guard let self else { return }
                showPickerView()
            }
            .disposed(by: disposeBag)
        
        chatTextView.rx
            .didChange
            .bind(with: self) { owner, _ in
                if owner.chatTextView.contentSize.height < owner.chatTextView.font!.lineHeight * 4 {
                    owner.chatTextView.snp.updateConstraints { make in
                        make.height.equalTo(owner.chatTextView.contentSize.height)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

extension DMChattingViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let itemProvider = results.first?.itemProvider, 
                itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let self else { return }
            if let image = image as? UIImage {
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
