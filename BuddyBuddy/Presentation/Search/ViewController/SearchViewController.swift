//
//  SearchViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SearchViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: SearchViewModel
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search".localized()
        controller.searchBar.tintColor = .blue
        controller.searchBar.sizeToFit()
        controller.searchBar.setBackgroundImage(
            UIImage(),
            for: .any,
            barMetrics: .default
        )
        let searchTextField = controller.searchBar.searchTextField
        searchTextField.backgroundColor = .primary.withAlphaComponent(0.3)
        searchTextField.clipsToBounds = true
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 18
        searchTextField.layer.borderColor = UIColor.primary.withAlphaComponent(0.3).cgColor
        return controller
    }()
    private let searchedResult: SearchResultView = SearchResultView()
    private let channelAlert: BuddyAlert = BuddyAlert(
        title: "채널 참여",
        leftButtonTitle: "취소",
        rightButtonTitle: "확인",
        hasTwoButton: true
    )
    
    init(vm: SearchViewModel) {
        self.vm = vm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textField = searchController.searchBar.searchTextField
        textField.subviews.first?.subviews.first?.removeFromSuperview()
    }
    
    override func bind() {
        let input = SearchViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
            inputText: searchController.searchBar.rx.searchButtonClicked
                .withLatestFrom(searchController.searchBar.rx.text.orEmpty),
            inputSegIndex: searchedResult.segmentedControl.rx.selectedSegmentIndex.map { $0 },
            selectedCell: searchedResult.searchResultTableView.rx
                .modelSelected(SearchResult.self).map { $0 },
            searchCancelBtnTapped: searchController.searchBar.rx.cancelButtonClicked.map { () },
            leftButtonTapped: channelAlert.leftButton.rx.tap.map {()},
            rightButtonTapped: channelAlert.rightButton.rx.tap.map {()},
            tappedAroundAlert: channelAlert.rx.tap
        )
        let output = vm.transform(input: input)
        
        var imageType = SearchImageType.channel
        
        output.searchData
            .drive { image in
                imageType = image
            }
            .disposed(by: disposeBag)
        
        output.selectedSegIndex
            .drive(with: self) { owner, segIndex in
                owner.searchedResult.segmentedControl.selectedSegmentIndex = segIndex
            }
            .disposed(by: disposeBag)
        
        output.searchedResult
            .drive(searchedResult.searchResultTableView.rx.items(
                cellIdentifier: SearchItemTableViewCell.identifier,
                cellType: SearchItemTableViewCell.self
            )) { _, data, cell in
                cell.setupUI(text: data.name)
                cell.setupImageUI(imgType: imageType)
            }
            .disposed(by: disposeBag)
        
        output.emptyResult
            .drive(with: self) { owner, isEmpty in
                owner.searchedResult.showEmptyView(isEmpty)
            }
            .disposed(by: disposeBag)
        
        output.channelAlert
            .drive(with: self) { owner, aboutChannels in
                let showAlert = aboutChannels.0
                let channelName = aboutChannels.1
                owner.setAlertHidden(showAlert)
                owner.channelAlert
                    .setMessageBody(AlertLiteral.joinChannel(channelName: channelName))
            }
            .disposed(by: disposeBag)
    }
    
    override func setNavigation() {
        super.setNavigation()
        title = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func setHierarchy() {
        [searchedResult, channelAlert].forEach {
            view.addSubview($0)
        }
        
        /// alert 숨김
        setAlertHidden(true, animated: false)
    }
    
    override func setConstraints() {
        searchedResult.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        channelAlert.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchViewController {
    private func setAlertHidden(_ isHidden: Bool, animated: Bool = true) {
        if animated {
            let duration: TimeInterval = isHidden ? 0.1 : 0.18
            UIView.animate(
                withDuration: duration,
                animations: { [weak self] in
                    guard let self else { return }
                    channelAlert.alpha = isHidden ? 0 : 1
                },
                completion: { [weak self] _ in
                    guard let self else { return }
                    channelAlert.isHidden = isHidden
                }
            )
        } else {
            channelAlert.isHidden = isHidden
            channelAlert.alpha = isHidden ? 0 : 1
        }
    }
}
