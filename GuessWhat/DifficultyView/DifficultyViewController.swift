//
//  DifficultyViewController.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

enum Difficulty: String {
    case easy
    case medium
    case hard
    
    var value: (letters:Int, attempts:Int) {
        switch self {
        case .easy:
            return (4,5)
        case .medium:
            return (5,4)
        case .hard:
            return (6,3)
        }
    }
}

class DifficultyViewController: UIViewController {
    
    private let containerView = ContainerView()
    private let titleLabel = CustomLabel(textAlignment: .center, fontSize: 20, fontWeight: .bold)
    
    private let easyButton = CustomButton(background: .systemPink, title: Difficulty.easy.rawValue.capitalized)
    private let mediumButton = CustomButton(background: .systemPink, title: Difficulty.medium.rawValue.capitalized)
    private let hardButton = CustomButton(background: .systemPink, title: Difficulty.hard.rawValue.capitalized)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .black.withAlphaComponent(0.75)
        titleLabel.text = "Change difficulty"
        easyButton.addTarget(self, action: #selector(easyButtonTapped), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(mediumButtonTapped), for: .touchUpInside)
        hardButton.addTarget(self, action: #selector(hardButtonTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        
        let stackView = UIStackView(arrangedSubviews: [easyButton, mediumButton, hardButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, stackView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  padding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -padding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:  -padding),
        ])
    }
    
    @objc private func easyButtonTapped() {
        Constants.difficulty = .easy
        dismiss(animated: true)
    }
    
    @objc private func mediumButtonTapped() {
        Constants.difficulty = .medium
        dismiss(animated: true)
    }
    
    @objc private func hardButtonTapped() {
        Constants.difficulty = .hard
        dismiss(animated: true)
    }
}
