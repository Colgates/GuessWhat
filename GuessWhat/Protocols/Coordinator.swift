//
//  Coordinator.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

enum Event {
    case newGame
    case difficulty
    case goBackToHome
    case exit
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
