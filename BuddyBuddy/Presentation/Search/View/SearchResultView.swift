//
//  SearchResultView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/12/24.
//

import UIKit

import SnapKit

final class SearchResultView: BaseView {
    let segmentedControl: UISegmentedControl = {
        let view = UnderlineSegmentedControl(items: ["Channel".localized(), "User".localized()])
        view.selectedSegmentIndex = 0
        return view
    }()
    let searchResultTableView: UITableView = {
        let view = UITableView()
        view.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.identifier
        )
        view.register(
            SearchUserTableViewCell.self,
            forCellReuseIdentifier: SearchUserTableViewCell.identifier
        )
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private let emptyView = SearchEmptyView()
    
    override func setHierarchy() {
        [segmentedControl, searchResultTableView, emptyView]
            .forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    func showEmptyView(_ isResultEmpty: Bool) {
        if isResultEmpty {
            emptyView.isHidden = false
            searchResultTableView.isHidden = true
        } else {
            emptyView.isHidden = true
            searchResultTableView.isHidden = false
        }
    }
}
