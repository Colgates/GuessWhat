//
//  CustomButton.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(background: UIColor, title: String) {
        self.init(frame: .zero)
        configure(background: background, title: title)
    }
    
    private func configure(background: UIColor = .blue, title: String = "") {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = background
        configuration.baseForegroundColor = .label
        configuration.background.strokeColor = .label
        configuration.background.strokeWidth = 2.0
        configuration.title = title
        self.configuration = configuration
        translatesAutoresizingMaskIntoConstraints = false
        
        configurationUpdateHandler = { button in
            var config = button.configuration
            config?.baseBackgroundColor = button.isHighlighted ? UIColor.systemPink : UIColor.clear
            button.configuration = config
        }
    }
}
