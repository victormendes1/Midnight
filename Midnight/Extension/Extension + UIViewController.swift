//
//  Extension + UIViewController.swift
//  Midnight
//
//  Created by Victor Mendes on 04/11/22.
//

import UIKit

// MARK: - Navigation
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
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Scene Loading
protocol Loading {
    func showLoading(active: Bool)
}

extension UIViewController: Loading {
    func showLoading(active: Bool) {
        LoadingScene.showLoadingView(active)
    }
}

// MARK: - Search bar cancel button
extension UIViewController {
    func setBarButtonAppearance() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}
