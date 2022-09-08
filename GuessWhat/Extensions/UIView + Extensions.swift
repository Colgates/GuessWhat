//
//  UIView + Extensions.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 07.09.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
