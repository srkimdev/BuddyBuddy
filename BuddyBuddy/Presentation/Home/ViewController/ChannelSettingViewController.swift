//
//  ChannelSettingViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/13/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ChannelSettingViewController: BaseViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let vm: ChannelSettingViewModel
    
    private let settingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    private let topView = ChannelSettingTopView()
    private let middleView = ChannelSettingMiddleView()
    private let bottomView = ChannelSettingBottomView()
    private let tapGesture = PublishRelay<Void>()
    
    init(vm: ChannelSettingViewModel) {
        self.vm = vm
        
        super.init()
    }
    
    override func bind() {
        let input = ChannelSettingViewModel.Input(blindViewTapped: tapGesture.map { () })
        let output = vm.transform(input: input)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func setHierarchy() {
        view.addSubview(settingContainerView)
        [topView, middleView, bottomView].forEach {
            settingContainerView.addSubview($0)
        }
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    override func setConstraints() {
        settingContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.bottom.trailing.equalToSuperview()
            make.width.equalTo(safeArea.snp.width).multipliedBy(0.85)
        }
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(settingContainerView)
        }
        bottomView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(settingContainerView)
            make.height.equalTo(70)
        }
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.horizontalEdges.equalTo(settingContainerView)
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    override func setView() {
        super.setView()
        
        view.backgroundColor = .white.withAlphaComponent(0.2)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        if !settingContainerView.frame.contains(tapLocation) {
            tapGesture.accept(())
        }
    }
}
