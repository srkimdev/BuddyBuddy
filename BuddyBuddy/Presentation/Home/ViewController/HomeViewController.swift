//
//  HomeViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

final class HomeViewController: BaseNavigationViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    @Dependency(NetworkProtocol.self) private var service: NetworkProtocol
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
        config.contentInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
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
            ChannelTableViewCell.self,
            forCellReuseIdentifier: ChannelTableViewCell.identifier
        )
        view.register(
            ChannelAddTableViewCell.self,
            forCellReuseIdentifier: ChannelAddTableViewCell.identifier
        )
        
        view.separatorStyle = .none
        view.isScrollEnabled = false
        return view
    }()
    private let memberAddBtn: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(pointSize: 13)
        var attr = AttributedString.init("Add Member".localized())
        
        attr.font = UIFont.body
        
        config.attributedTitle = attr
        config.preferredSymbolConfigurationForImage = imgConfig
        config.image = UIImage(systemName: "plus")
        config.imagePlacement = .leading
        config.imagePadding = 12
        config.baseForegroundColor = .gray1
        config.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 0
        )
        
        view.configuration = config
        view.backgroundColor = .white
        view.contentHorizontalAlignment = .left
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
        config.contentInsets = .init(
            top: 16.45,
            leading: 16.45,
            bottom: 16.45,
            trailing: 16.45
        )
        
        view.configuration = config
        view.layer.cornerRadius = 25
        view.backgroundColor = .primary
        view.drawShadow(
            radius: 25,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        return view
    }()
    private let toastMsgLabel: ToastMessageLabel = {
        let view = ToastMessageLabel()
        view.text = "채널이 생성되었습니다"
        return view
    }()
    private lazy var datasource = createDataSource()
    private var isTableViewBound = false
    private let configureChannelCell = PublishRelay<MyChannel>()
    
    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.just(())
            .flatMap {
                let login = LoginQuery(email: "compose@coffee.com", password: "1q2w3e4rQ!")
                return self.service.callRequest(
                    router: LogInRouter.login(query: login),
                    responseType: LogInDTO.self
                )
            }
            .bind(with: self) { _, response in
                switch response {
                case .success(let value):
                    print(value)
                    KeyChainManager.shared.saveAccessToken(value.token.accessToken)
                    KeyChainManager.shared.saveRefreshToken(value.token.refreshToken)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        let repo = RealmRepository<DMHistoryTable>()
        repo.detectRealmURL()
    }
    
    override func bind() {
        let input = HomeViewModel.Input(
            viewWillAppearTrigger: rx.viewWillAppear,
            configureChannelCell: configureChannelCell.asObservable(),
            menuBtnDidTap: menuBtn.rx.tap.map { _ in }.asObservable(),
            channelItemDidSelected: channelTableView.rx.itemSelected.asObservable(),
            addMemeberBtnDidTap: memberAddBtn.rx.tap.map { _ in }.asObservable(),
            floatingBtnDidTap: floatingBtn.rx.tap.map { _ in }.asObservable()
        )
        let output = vm.transform(input: input)
        
        output.navigationTitle
            .drive(with: self) { owner, title in
                owner.title = title
            }
            .disposed(by: disposeBag)
        
        output.updateChannelState
            .do(onNext: { [weak self] sections in
                guard let self else { return }
                updateTableViewHeight(sections: sections)
            })
            .drive(channelTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    override func setNavigation() {
        super.setNavigation()
        
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
        [scrollView, floatingBtn, toastMsgLabel].forEach {
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
        toastMsgLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeArea).offset(-12)
        }
    }
}

// MARK: RxDataSource
extension HomeViewController {
    private func createDataSource() -> RxTableViewSectionedReloadDataSource<ChannelSectionModel> {
        return RxTableViewSectionedReloadDataSource<ChannelSectionModel> { [weak self] datasource, _, indexpath, _ in
            guard let self else { return UITableViewCell() }
            
            switch datasource[indexpath] {
            case .title(let item):
                guard let cell = channelTableView.dequeueReusableCell(
                    withIdentifier: ChannelTitleTableViewCell.identifier,
                    for: indexpath
                ) as? ChannelTitleTableViewCell else { return UITableViewCell() }
                cell.configureCell(data: item.rawValue)
                cell.selectionStyle = .none
                return cell
            case .channel(let item):
                guard let cell = channelTableView.dequeueReusableCell(
                    withIdentifier: ChannelTableViewCell.identifier,
                    for: indexpath
                ) as? ChannelTableViewCell else { return UITableViewCell() }
                
                configureChannelCell.accept(item)
                cell.configureCell(data: item)
                cell.selectionStyle = .none
                return cell
            case .add(let item):
                guard let cell = channelTableView.dequeueReusableCell(
                    withIdentifier: ChannelAddTableViewCell.identifier,
                    for: indexpath
                ) as? ChannelAddTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configureCell(title: item)
                return cell
            }
        }
    }
    
    private func updateTableViewHeight(sections: [ChannelSectionModel]) {
        channelTableView.snp.remakeConstraints { make in
            let heights = [56, 41, 48]
            var totalHeight = 0
            for (idx, section) in sections.enumerated() {
                totalHeight += section.items.count * heights[idx]
            }
            make.height.equalTo(totalHeight)
        }
    }
}
