//
//  ProfileImageView.swift
//  BuddyBuddy
//
//  Created by 김성률 on 12/3/24.
//

import UIKit

import Nuke
import NukeUI
import SnapKit

final class ProfileImageView: BaseView {
    private let imageView: LazyImageView = {
        let view = LazyImageView()
        let pipeline = ImagePipeline {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = [
                Header.authorization.rawValue: KeyChainManager.shared.getAccessToken() ?? "",
                Header.Key.rawValue: APIKey.Key
            ]
            $0.dataLoader = DataLoader(configuration: config)
            $0.isProgressiveDecodingEnabled = true
        }
        view.priority = .high
        view.pipeline = pipeline
        return view
    }()
    
    override func setHierarchy() {
        addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateURL(url: String) {
        imageView.url = URL(string: APIKey.baseURL + "/v1" + url)
    }
}
