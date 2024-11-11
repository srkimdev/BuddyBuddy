//
//  SearchViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxSwift
import SnapKit

final class SearchViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: SearchViewModel
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "search".localized()
        controller.searchBar.tintColor = .blue
        controller.searchBar.sizeToFit()
        controller.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        let searchTextField = controller.searchBar.searchTextField
        searchTextField.backgroundColor = .primary.withAlphaComponent(0.3)
        searchTextField.clipsToBounds = true
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 18
        searchTextField.layer.borderColor = UIColor.primary.withAlphaComponent(0.3).cgColor
        return controller
    }()
    private let searchEmptyView: SearchEmptyView = SearchEmptyView()
    
    init(vm: SearchViewModel) {
        self.vm = vm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textField = searchController.searchBar.searchTextField
        textField.subviews.first?.subviews.first?.removeFromSuperview()
    }
    
    override func bind() {
        
    }
    
    override func setNavigation() {
        super.setNavigation()
        title = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func setHierarchy() {
        [searchEmptyView]
            .forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        searchEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
