//
//  HomeViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxSwift
import SnapKit

final class HomeViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: HomeViewModel
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.distribution = .fill
        view.backgroundColor = .gray2
        return view
    }()
    private let menuBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        
        config.image = .menu
        view.configuration = config
        return view
    }()
    private let channelView: UIView = ChannelView()
    private let memberAddBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("Add Member".localized())
        
        attr.font = UIFont.body
        attr.foregroundColor = .gray1
        
        config.attributedTitle = attr
        config.image = UIImage(systemName: "plus")
        config.imagePlacement = .leading
        config.imagePadding = 16
        
        view.configuration = config
        view.backgroundColor = .white
        return view
    }()
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setContentHuggingPriority(.init(1), for: .vertical)
        return view
    }()
    private let floatingBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        
        config.image = .newMessage
        config.contentInsets = .init(top: 16.45, leading: 16.45, bottom: 16.45, trailing: 16.45)
        
        view.configuration = config
        view.layer.cornerRadius = 25
        view.backgroundColor = .primary
        return view
    }()
    
    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    override func setHierarchy() {
        [scrollView, floatingBtn].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(stackView)
        
        [channelView, memberAddBtn, emptyView].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        channelView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        memberAddBtn.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        emptyView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        floatingBtn.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(50)
        }
    }
}
