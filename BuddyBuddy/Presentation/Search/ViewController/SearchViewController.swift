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
    
    init(vm: SearchViewModel) {
        self.vm = vm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textField = searchController.searchBar.searchTextField
        textField.subviews.first?.subviews.first?.removeFromSuperview()
    }
    
    override func bind() {
        let input = SearchViewModel.Input(viewWillAppear: rx.viewWillAppear)
        let output = vm.transform(input: input)
        
        output.searchState
            .drive(with: self) { owner, state in
                owner.updateSearchUI(state)
            }
            .disposed(by: disposeBag)
        
        output.recentSearchList
            .drive(recentSearchView.recentTableView.rx.items(
                    cellIdentifier: RecentTableViewCell.identifier,
                    cellType: RecentTableViewCell.self
            )) { _, terms, cell in
                cell.setTerms(text: terms)
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
        [searchEmptyView, recentSearchView]
            .forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        searchEmptyView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        recentSearchView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func updateSearchUI(_ state: SearchState) {
        switch state {
        case .empty:
            recentSearchView.isHidden = true
        case .recentSearch:
            searchEmptyView.isHidden = true
        case .searchResult:
            searchEmptyView.isHidden = true
        }
    }
}
