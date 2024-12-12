//
//  NetworkDisconnectViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/12/24.
//

import UIKit

import SnapKit

/**
- 해당 객체: Network가 끊겼을 때 보여질 VC
- 객체가 생성될 때, Notification보내줄 Observer 등록
- `NetworkMonitor` 객체에서 네트워크 연결에 따라 NotificationObserver에 이벤트 post
- 네트워크 연결에 따라 timer 등록 및 등록된 타이머 삭제(`networkConnected/networkDisconnected` method)
 */
final class NetworkDisconnectViewController: BaseViewController {
    private let networkProgress: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.tintColor = .yellow
        return view
    }()
    private let disconnectTitle: UILabel = {
        let view = UILabel()
        view.font = .title1
        view.textColor = .gray1
        view.text = "NetworkDisConnected".localized()
        view.textAlignment = .center
        return view
    }()
    private let disconnectSubTitle: UILabel = {
        let view = UILabel()
        view.font = .naviTitle
        view.textColor = .gray1
        view.text = "NetworkDisConnectedSubTitle".localized()
        view.textAlignment = .center
        return view
    }()
    
    private var fatalErrorTask: DispatchWorkItem?
    
    override init() {
        super.init()
        
        setupNotifications()
    }
    
    deinit {
        print("== NetworkDisconnectVC DEINIT ==")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setHierarchy() {
        [networkProgress, disconnectTitle, disconnectSubTitle].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        networkProgress.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(150)
            make.centerX.equalTo(safeArea)
            make.horizontalEdges.equalToSuperview().inset(110)
            make.height.equalTo(networkProgress.snp.width)
        }
        disconnectTitle.snp.makeConstraints { make in
            make.top.equalTo(networkProgress.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        disconnectSubTitle.snp.makeConstraints { make in
            make.top.equalTo(disconnectTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        setProgressView()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkConnected),
            name: .networkConnected,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkDisconnected),
            name: .networkDisconnected,
            object: nil
        )
    }
    
    private func setProgressView() {
        guard let gifURL = Bundle.main.url(
            forResource: "ProgressAnimation",
            withExtension: "gif"
        ),
              let gifData = try? Data(contentsOf: gifURL),
              let source = CGImageSourceCreateWithData(
                gifData as CFData,
                nil
              )
        else {
            print("Error with gifURL, gifData, Source in \(#file)")
            return
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        
        (0..<frameCount).compactMap {
            CGImageSourceCreateImageAtIndex(
                source,
                $0,
                nil
            )
        }.forEach {
            images.append(UIImage(cgImage: $0))
        }
        
        networkProgress.animationImages = images
        networkProgress.animationDuration = TimeInterval(frameCount) * 0.05
        networkProgress.animationRepeatCount = 0
        networkProgress.startAnimating()
    }
    
    private func setFatalErrorTimer() {
        fatalErrorTask?.cancel()
        fatalErrorTask = DispatchWorkItem {
            exit(EXIT_SUCCESS)
        }
        DispatchQueue.global().asyncAfter(
            deadline: .now() + 7,
            execute: fatalErrorTask ?? DispatchWorkItem(block: {()})
        )
    }
    
    /// Network 연결 O
    @objc private func networkConnected() {
        fatalErrorTask?.cancel()
        fatalErrorTask = nil
    }
    
    /// Network 연결 X
    @objc private func networkDisconnected() {
        setFatalErrorTimer()
    }
}
