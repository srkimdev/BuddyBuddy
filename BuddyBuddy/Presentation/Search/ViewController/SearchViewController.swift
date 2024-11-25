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
            viewWillAppear: Observable.just(()),
            inputText: searchController.searchBar.rx.searchButtonClicked
                .withLatestFrom(searchController.searchBar.rx.text.orEmpty),
            inputSegIndex: searchedResult.segmentedControl.rx.selectedSegmentIndex.map { $0 },
            selectedCell: searchedResult.searchResultTableView.rx
                .modelSelected(SearchResult.self).map { $0 }
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
    }
    
    override func setNavigation() {
        super.setNavigation()
        title = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func setHierarchy() {
        [searchedResult].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchedResult.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}
