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
    private let searchEmptyView: SearchEmptyView = SearchEmptyView()
    private let recentSearchView: RecentSearchTableView = RecentSearchTableView()
    private let searchedResult: SearchResultView = SearchResultView()
    
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
            inputSegIndex: searchedResult.segmentedControl.rx.selectedSegmentIndex.map { $0 }
        )
        let output = vm.transform(input: input)
        var imageType: SearchImageType = .clock
        output.searchData
            .drive { imgType in
                imageType = imgType
            }
            .disposed(by: disposeBag)
        output.searchState
            .drive(with: self) { owner, state in
                owner.updateSearchUI(state)
            }
            .disposed(by: disposeBag)
        output.recentSearchList
            .drive(searchedResult.searchResultTableView.rx.items(
                    cellIdentifier: SearchItemTableViewCell.identifier,
                    cellType: SearchItemTableViewCell.self
            )) { _, terms, cell in
                cell.setupUI(text: terms)
                cell.setupImageUI(imgType: imageType)
            }
            .disposed(by: disposeBag)
        
        output.selectedSegIndex
            .drive(with: self) { owner, segIndex in
                owner.searchedResult.segmentedControl.selectedSegmentIndex = segIndex
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
        [searchEmptyView, recentSearchView, searchedResult]
            .forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        searchEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        recentSearchView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        searchedResult.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func updateSearchUI(_ state: SearchState) {
        switch state {
        case .empty:
            recentSearchView.isHidden = true
            searchedResult.isHidden = true
        case .recentSearch:
            searchEmptyView.isHidden = true
            searchedResult.isHidden = true
        case .searchResult:
            searchEmptyView.isHidden = true
            recentSearchView.isHidden = true
        }
    }
}
