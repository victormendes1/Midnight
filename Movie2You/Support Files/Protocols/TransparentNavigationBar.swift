//
//  TransparentNavigationBar.swift
//  Movie2You
//
//  Created by Victor Mendes on 04/11/22.
//

import UIKit

protocol TransparentNavigationBar where Self: UIViewController {
    func setNavigationController(button: UIButton)
}

extension TransparentNavigationBar {
    func setNavigationController(button: UIButton) {
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

        button.frame = CGRect(x: .zero, y: .zero, width: 30, height: 30)
        background.addSubview(button)
    
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: background)
    }
}

//
//protocol TransparentNavigationBar where Self: UIViewController {
//    var button: UIButton { get }
//    
//    func setNavigationController()
//}
//
//extension TransparentNavigationBar {
//    var button: UIButton {
//        UIButton(frame: CGRect(x: .zero, y: .zero, width: 30, height: 30))
//    }
//    
//    func setNavigationController() {
//        let appearanceNavigation = UINavigationBarAppearance()
//        appearanceNavigation.configureWithTransparentBackground()
//        navigationController?.navigationBar.standardAppearance = appearanceNavigation
//        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNavigation
//        navigationController?.navigationBar.compactAppearance = appearanceNavigation
//        let imageButtonView = UIImageView(image: UIImage(systemName: "chevron.backward"))
//        imageButtonView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
//        imageButtonView.tintColor = .white.withAlphaComponent(0.9)
//        imageButtonView.frame = CGRect(x: 7, y: 5, width: 15, height: 20)
//        
//        let backgroundView = UIView(frame: CGRect(x: .zero, y: .zero, width: 30, height: 30))
//        backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
//        backgroundView.layer.cornerRadius = 0.5 * backgroundView.bounds.size.width
//        backgroundView.addSubview(imageButtonView)
//        
//        button.addSubview(backgroundView)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
//    }
//}
