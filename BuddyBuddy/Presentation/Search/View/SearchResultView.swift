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
        let view = UnderlineSegmentedControl(items: ["채널", "사용자"])
        view.selectedSegmentIndex = 0
        return view
    }()
    let searchResultTableView: UITableView = {
        let view = UITableView()
        view.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.identifier
        )
        view.rowHeight = 41
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func setHierarchy() {
        [segmentedControl, searchResultTableView]
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
    }
}
