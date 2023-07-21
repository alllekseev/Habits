//
//  UIView + ext.swift
//  Habits
//
//  Created by Олег Алексеев on 18.07.2023.
//

import UIKit

extension UIView {

    func debugOutline(color: UIColor = .red, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat = 0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
