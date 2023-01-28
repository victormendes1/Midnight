//
//  Extension + UIViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 04/11/22.
//

import UIKit

extension UIViewController {
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationControllerTransparent(with button: UIButton = .transparentButton) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        button.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        
        let image = UIView.backIconView
        image.addSubview(button)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: image)
    }
    
    func setNavigationControllerDark(title: String) {
        self.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .black.withAlphaComponent(0.9)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
}
