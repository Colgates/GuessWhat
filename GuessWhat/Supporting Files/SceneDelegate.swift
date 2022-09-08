//
//  SceneDelegate.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navVC = UINavigationController()
        navVC.navigationBar.tintColor = .label
        
        let networkService = APIClient()
        
        let coordinator = MainCoordinator(networkService: networkService)
        coordinator.navigationController = navVC
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = navVC
        self.window = window
        
        coordinator.start()
    }
}

