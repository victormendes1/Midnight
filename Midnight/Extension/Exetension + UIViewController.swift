//
//  Exetension + UIViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/11/22.
//

import UIKit
import SnapKit

protocol Pop {
    func backToPrevious()
}

extension UIViewController: Pop {
    @objc internal func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    func setNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let image = UIImageView(image: UIImage(systemName: "chevron.backward"))
        image.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        image.tintColor = .white.withAlphaComponent(0.9)
        
        let background = UIView(frame: CGRect(x: .zero, y: .zero, width: 30, height: 30))
        background.backgroundColor = .black.withAlphaComponent(0.5)
        
        background.layer.cornerRadius = 0.5 * background.bounds.size.width
        background.addSubview(image)
        
        image.frame = CGRect(x: 7, y: 5, width: 15, height: 20)
        
        let button = UIButton(frame: CGRect(x: .zero, y: .zero, width: 30, height: 30))
        background.addSubview(button)
        button.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: background)
    }
    
    func setNavigationController(title: String) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        navigationController?.navigationBar.barStyle = .black
        self.title = title
    }
}
