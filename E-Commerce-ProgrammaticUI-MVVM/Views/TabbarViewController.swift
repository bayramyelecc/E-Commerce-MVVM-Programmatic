//
//  TabbarViewController.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        tabbarDrawer()
    }
    
    private func setupTabbar(){
        let homevc = HomeVC()
        let homenav = UINavigationController(rootViewController: homevc)
        
        let searchVC = SearchTableView()
        let searchNav = UINavigationController(rootViewController: searchVC)
        
        let favoritesvc = FavoritesVC()
        let favnav = UINavigationController(rootViewController: favoritesvc)
        
        let profilevc = ProfileVC()
        let profnav = UINavigationController(rootViewController: profilevc)
        
        homevc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        favoritesvc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        profilevc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [homenav, searchNav, favnav, profnav]
    }
    
    private func tabbarDrawer(){
        tabBar.backgroundColor = .white
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.systemPurple
        tabBar.unselectedItemTintColor = UIColor.systemGray2
    }

}
