//
//  Extension + UIView.swift
//  Midnight
//
//  Created by Victor Mendes on 06/01/23.
//

import UIKit

extension UIView {
    static var backIconView: UIView {
        let image = UIImageView(image: UIImage(systemName: "chevron.backward"))
        image.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        image.tintColor = .white.withAlphaComponent(0.9)
        image.frame = CGRect(x: 7, y: 5, width: 15, height: 20)
        
        let background = UIView(frame: CGRect(x: .zero, y: .zero, width: 30, height: 30))
        background.backgroundColor = .black.withAlphaComponent(0.5)
        background.layer.cornerRadius = 0.5 * background.bounds.size.width
        background.addSubview(image)
        return background
    }
}
