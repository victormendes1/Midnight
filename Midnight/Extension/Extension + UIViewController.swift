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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        button.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        let image = UIView.backIconView
        image.addSubview(button)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: image)
    }
    
    func setNavigationControllerDark(title: String, hideBar: Bool = false) {
        self.title = title
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        
        navigationController?.hidesBarsOnSwipe = hideBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
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
