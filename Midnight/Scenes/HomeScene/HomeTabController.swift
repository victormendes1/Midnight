//
//  HomeTabController.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import UIKit

final class HomeTabController: UITabBarController {
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barStyle = .black
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationControllerDark(title: "Popular")
    }
    
    func setTabBarImage() {
        tabBar.items?.first?.image = UIImage(systemName: "play.tv")
        tabBar.items?.last?.image = UIImage(systemName: "rectangle.stack.badge.play")
        tabBar.items?.first?.title = "Popular"
        tabBar.items?.last?.title = "Upcoming"
    }
}

// MARK: - Extension
extension HomeTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController is UpcomingMoviesViewController ? setNavigationControllerDark(title: "Upcoming") : setNavigationControllerDark(title: "Popular")
    }
}
