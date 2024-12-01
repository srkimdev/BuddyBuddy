//
//  PlaygroundViewController.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/29/24.
//

import UIKit

import SnapKit

final class PlaygroundViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private let playgroundTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    private let bottomView: PlaygroundBottomView = PlaygroundBottomView()
    
    override func setHierarchy() {
        [titleLabel, playgroundTableView, bottomView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(8)
            make.leading.equalToSuperview().inset(16
            )
        }
        playgroundTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.horizontalEdges.equalToSuperview()
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(playgroundTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeArea)
            make.height.equalTo(82)
        }
    }
}
