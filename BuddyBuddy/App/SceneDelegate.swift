//
//  SceneDelegate.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/5/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: Coordinator?
    var networkWindow: UIWindow?
    var socketService: SocketProtocol?
    var networkMonitor: NetworkMonitorInterface = NetworkMonitorService()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        networkMonitor.startMonitoring()
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        networkMonitor.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    // 포어그라운드 진입 시 소켓통신 재연결
    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("willEnterForeground"), object: nil)
    }

    // 백그라운드 진입 시 소켓통신 끊기
    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("didEnterBackground"), object: nil)
    }
}


