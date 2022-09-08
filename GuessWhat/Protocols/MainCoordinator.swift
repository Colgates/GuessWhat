//
//  MainCoordinator.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func eventOccured(with type: Event) {
        switch type {
        case .newGame:
            let viewmodel = GameViewModel(networkService: networkService)
            var vc: UIViewController & Coordinating = GameViewController(viewmodel: viewmodel)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        
        case .difficulty:
            DispatchQueue.main.async {
                let vc = DifficultyViewController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.navigationController?.present(vc, animated: true)
            }
            
        case .goBackToHome:
            navigationController?.popToRootViewController(animated: true)
        
        case .exit:
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = MainViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: true)
    }
}
