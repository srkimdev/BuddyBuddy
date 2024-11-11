//
//  ChannelView.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/11/24.
//

import UIKit

import SnapKit

final class ChannelView: BaseView {
    private let channelBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("Channel".localized())
        
        attr.font = UIFont.title2
        
        config.attributedTitle = attr
        config.image = UIImage(systemName: "chevron.right")
        config.imagePlacement = .trailing
        config.imagePadding = .infinity
        
        view.configuration = config
        return view
    }()
    private let channelTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 41
        return view
    }()
    private let addBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("Add Channel".localized())
        
        attr.font = UIFont.body
        
        config.attributedTitle = attr
        config.image = UIImage(systemName: "plus")
        config.imagePlacement = .leading
        config.imagePadding = 16
        
        view.configuration = config
        return view
    }()

    override func setHierarchy() {
        [channelBtn, channelTableView, addBtn].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        channelBtn.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(52)
        }
        
        channelTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        addBtn.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
