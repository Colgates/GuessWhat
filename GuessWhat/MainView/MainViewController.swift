//
//  ViewController.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

class MainViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    private let titleLabel = CustomLabel(textAlignment: .center, fontSize: 52, fontWeight: .heavy)
    
    private let newGameButton = CustomButton(background: .clear, title: "NEW GAME")
    private let difficultyButton = CustomButton(background: .clear, title: "DIFFICULTY")
    private let exitButton = CustomButton(background: .clear, title: "EXIT")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureButtons()
        configureStack()
        addConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        titleLabel.text = "Guess, \nWhat?"
    }
    
    private func configureButtons() {
        newGameButton.addTarget(self, action: #selector(newGameTapped), for: .touchUpInside)
        difficultyButton.addTarget(self, action: #selector(difficultyButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    private func configureStack() {
        let stackView = UIStackView(arrangedSubviews: [newGameButton, difficultyButton, exitButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func addConstraints() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
        ])
    }
    
    @objc private func newGameTapped() {
        coordinator?.eventOccured(with: .newGame)
    }
    
    @objc private func difficultyButtonTapped() {
        coordinator?.eventOccured(with: .difficulty)
    }
    
    @objc private func exitButtonTapped() {
        coordinator?.eventOccured(with: .exit)
    }
}

