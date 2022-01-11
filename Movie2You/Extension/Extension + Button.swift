//
//  Extension + Button.swift
//  Movie2You
//
//  Created by Victor Mendes on 10/01/22.
//

import UIKit

//This property creates a custom button and so the View doesn't get cluttered I created an extension
extension UIButton {
    var customBackButton: UIButton {
        let button = UIButton(frame: CGRect(x: 16, y: 45, width: 30, height: 30))
        let arrowImage = UIImage(named: "white_back_arrow")
        button.backgroundColor = .black.withAlphaComponent(0.7)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setImage(arrowImage, for: .normal)
        return button
    }
}
