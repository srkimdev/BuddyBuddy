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
        config.image = UIImage(systemName: "chevron.down")
        config.imagePlacement = .trailing
//        config.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
//        config.imagePadding = .infinity
        config.baseForegroundColor = .black
        
        view.configuration = config
        view.backgroundColor = .white
        view.contentHorizontalAlignment = .left
        return view
    }()
    private let channelTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 41
        view.backgroundColor = .white
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
        config.baseForegroundColor = .gray1
        
        view.configuration = config
        view.backgroundColor = .white
        view.contentHorizontalAlignment = .left
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
            make.top.equalTo(channelBtn.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
        }
        addBtn.snp.makeConstraints { make in
            make.top.equalTo(channelTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}
