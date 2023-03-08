//
//  HomeTabController.swift
//  Midnight
//
//  Created by Victor Mendes on 13/12/22.
//

import UIKit

final class HomeTabController: UITabBarController {
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
        
        setTabBarColor()
        setBarButtonAppearance()
    }
    
    private func setTabBarColor() {
        tabBar.barStyle = .black
        tabBar.tintColor = .orange
    }
}
