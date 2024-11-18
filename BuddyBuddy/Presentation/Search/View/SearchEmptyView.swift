//
//  SearchEmptyView.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/11/24.
//

import UIKit

final class SearchEmptyView: BaseView {
    private let emptyView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "playground")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let emptyText: UILabel = {
        let view = UILabel()
        view.text = "EmptySearch".localized()
        view.textColor = .gray1
        view.font = .body
        return view
    }()
    
    override func setHierarchy() {
        [emptyView, emptyText].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(180)
        }
        emptyText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyView.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
    }
}
