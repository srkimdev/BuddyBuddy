//
//  HomeViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxDataSources
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
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        view.configuration = config
        return view
    }()
    private let channelTableView: UITableView = {
        let view = UITableView()
        view.register(
            ChannelTitleTableViewCell.self,
            forCellReuseIdentifier: ChannelTitleTableViewCell.identifier
        )
        view.register(
            DefaultChannelTableViewCell.self,
            forCellReuseIdentifier: DefaultChannelTableViewCell.identifier
        )
        view.register(
            UnreadChannelTableViewCell.self,
            forCellReuseIdentifier: UnreadChannelTableViewCell.identifier
        )
        return view
    }()
    private let memberAddBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var attr = AttributedString.init("Add Member".localized())
        
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
    
    override func setNavigation() {
        super.setNavigation()
        
        title = "영어 마스터 할 사람 모여라"
        
        let appearance = UINavigationBarAppearance()
        appearance.titlePositionAdjustment = UIOffset(
            horizontal: -(view.frame.width/2),
            vertical: 2
        )
        let font = UIFont.title1 ?? UIFont.boldSystemFont(ofSize: 22)
        appearance.titleTextAttributes =
        [NSAttributedString.Key.font: font]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        let barItem = UIBarButtonItem(customView: menuBtn)
        
        navigationItem.leftBarButtonItem = barItem
    }
    
    override func setHierarchy() {
        [scrollView, floatingBtn].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(stackView)
        
        [channelTableView, memberAddBtn, emptyView].forEach {
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
        
        channelTableView.snp.makeConstraints { make in
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

// MARK: RxDataSource
extension HomeViewController {
    private func createDataSource() -> RxTableViewSectionedReloadDataSource {
        RxTableViewSectionedReloadDataSource<SectionModel(model: <#T##Section#>, items: <#T##[SectionModel<Section, ItemType>.Item]#>)
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: configureCell)
        Observable.just([SectionModel(model: "title", items: [1, 2, 3])])
        .bind(to: channelTableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}
