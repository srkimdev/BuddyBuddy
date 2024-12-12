//
//  NetworkDisconnectViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/12/24.
//

import UIKit

import SnapKit

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
    
    override init() {
        super.init()
        
        setFatalError()
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
        
        (0..<frameCount)
            .compactMap { CGImageSourceCreateImageAtIndex(source, $0, nil) }
            .forEach { images.append(UIImage(cgImage: $0)) }
        
        networkProgress.animationImages = images
        networkProgress.animationDuration = TimeInterval(frameCount) * 0.05
        networkProgress.animationRepeatCount = 0
        networkProgress.startAnimating()
    }
    
    private func setFatalError() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 7) {
            exit(EXIT_SUCCESS)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    NetworkDisconnectViewController()
}
