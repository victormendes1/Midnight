//
//  Button + Extension.swift
//  Movie2You
//
//  Created by Victor Mendes on 10/01/22.
//

import UIKit

extension UIButton {
    var customBackButton: UIButton {
        let button = UIButton(frame: CGRect(x: 16, y: 45, width: 35, height: 35))
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .black, scale: .large)
        let largeBackwardCircle = UIImage(systemName: "chevron.backward.circle.fill", withConfiguration: largeConfig)
        button.tintColor = .darkGray
        button.setImage(largeBackwardCircle, for: .normal)
        return button
    }
}
