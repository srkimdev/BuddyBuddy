//
//  NetworkMonitorService.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/12/24.
//

import UIKit
import Network

protocol NetworkMonitorInterface: AnyObject {
    func startMonitoring()
    func stopMonitoring()
}

final class NetworkMonitorService: NetworkMonitorInterface {
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                print("연결 O")
                self?.dismissNetworkWindow()
            case .unsatisfied:
                print("연결 X")
                self?.showNetworkWindow()
            case .requiresConnection:
                print("연결 X")
                self?.showNetworkWindow()
            @unknown default:
                fatalError()
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func showNetworkWindow() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let networkWindow = NetworkWindow(windowScene: windowScene)
                networkWindow.makeKeyAndVisible()
                
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                sceneDelegate?.networkWindow = networkWindow
            }
        }
    }
    
    private func dismissNetworkWindow() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                sceneDelegate?.networkWindow = nil
            }
        }
    }
}
