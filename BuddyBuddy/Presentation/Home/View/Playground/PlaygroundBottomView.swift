//
//  PlaygroundBottomView.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/30/24.
//

import UIKit

import SnapKit

final class PlaygroundBottomView: BaseView {
    let addButton: UIButton = {
        let view = UIButton()
        return view
    }()
    let helpButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    override func setHierarchy() {
        [addButton, helpButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(41)
        }
        helpButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(41)
        }
    }
}
