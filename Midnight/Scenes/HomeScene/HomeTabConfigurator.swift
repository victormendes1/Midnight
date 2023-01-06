//
//  HomeTabConfigurator.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import UIKit

// MARK: - Protocol
protocol HomeSceneConfiguratorProtocol {
    func configured(_ tabController: HomeTabController, viewControllers: [UIViewController]) -> UIViewController
}

// MARK: - Extension SceneConfigurator
extension SceneConfigurator: HomeSceneConfiguratorProtocol {
    func configured(_ tabViewController: HomeTabController, viewControllers: [UIViewController]) -> UIViewController {
        tabViewController.setViewControllers(viewControllers, animated: true)
        tabViewController.setTabBarImage()
        return tabViewController
    }
}
