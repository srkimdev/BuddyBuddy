//
//  HomeViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxSwift

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
        return view
    }()
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let floatingBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        
        config.image = .newMessage
        config.contentInsets = .init(top: 16.45, leading: 16.45, bottom: 16.45, trailing: 16.45)
        config.baseBackgroundColor = .primary
        
        view.configuration = config
        view.layer.cornerRadius = 25
        return view
    }()
    
    init(vm: HomeViewModel) {
        self.vm = vm
    }
}
