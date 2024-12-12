//
//  NetworkWindow.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/12/24.
//

import UIKit

final class NetworkWindow: UIWindow {
    private let networkVC = NetworkDisconnectViewController()
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        
        rootViewController = networkVC
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        windowLevel = .statusBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
