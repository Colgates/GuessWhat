//
//  GameViewController.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

class GameViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    private let viewmodel: GameViewModel
    
    init(viewmodel: GameViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let boardVC = BoardViewController()
    private let keyboardVC = KeyboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addChildren()
        addConstraints()
    }
    
    private func configureViewController() {
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hint", style: .plain, target: self, action: #selector(hintButtonTapped))
    }
    
    private func addChildren() {
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.dataSource = self
        view.addSubview(boardVC.view)
        
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.delegate = self
        view.addSubview(keyboardVC.view)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.topAnchor.constraint(equalTo: boardVC.view.bottomAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func hintButtonTapped() {
        viewmodel.fetchHint() { [weak self] result in
            self?.presentAlertOnMainThread(title: "Here's the hint:", message: result, buttonTitle: "Ok") {}
        }
    }
    
    private func showWinAlert() {
        presentAlertOnMainThread(title: "Congrats!", message: "Wow! You did it! Congratulations!", buttonTitle: "Ok") {
            self.coordinator?.eventOccured(with: .goBackToHome)
        }
    }
    
    private func showFailAlert() {
        presentAlertOnMainThread(title: "So sad!", message: "Better luck next time!", buttonTitle: "Ok") {
            self.coordinator?.eventOccured(with: .goBackToHome)
        }
    }
}

// MARK: - KeyboardViewControllerDelegate

extension GameViewController: KeyboardViewControllerDelegate {
    func buttonTapped(letter: Character) {
        viewmodel.buttonTapped(letter: letter) { [weak self] result in
            result ? self?.showWinAlert() : self?.showFailAlert()
        }
        boardVC.reloadData()
    }
}

// MARK: - BoardViewControllerDataSource

extension GameViewController: BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        viewmodel.guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        viewmodel.colorForCell(with: indexPath)
    }
}
