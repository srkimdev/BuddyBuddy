//
//  RecentSearchTableView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/11/24.
//

import UIKit

import SnapKit

final class RecentSearchTableView: BaseView {
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.font = .title2
        view.textColor = .black
        view.text = "RecentSearch".localized()
        view.numberOfLines = 0
        return view
    }()
    
    let recentTableView: UITableView = {
        let view = UITableView()
        view.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.identifier
        )
        view.rowHeight = 41
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func setHierarchy() {
        [headerLabel, recentTableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        recentTableView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
