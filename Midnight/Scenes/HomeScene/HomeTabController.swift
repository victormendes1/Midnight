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
    
    func setTabBar() {
        guard let tabBarItems = tabBar.items, tabBarItems.count <= 3 else { return }
        //Title
        tabBarItems[0].title = "Popular"
        tabBarItems[1].title = "Upcoming"
        tabBarItems[2].title = "Favotites"
        //Icon
        tabBarItems[0].image = UIImage(systemName: "play.tv")
        tabBarItems[1].image = UIImage(systemName: "rectangle.stack.badge.play")
        tabBarItems[2].image = UIImage(systemName: "star")
    }
    
    // MARK: - Private Function
    private func configureNavigationBy(type: UIViewController) {
        if type is PopularMoviesViewController {
            setNavigationControllerDark(title: "Popular")
        } else if type is UpcomingMoviesViewController {
            setNavigationControllerDark(title: "Upcoming")
        } else {
            setNavigationControllerDark(title: "Favorites")
        }
    }
}

// MARK: - Extension
extension HomeTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        configureNavigationBy(type: viewController)
    }
}
