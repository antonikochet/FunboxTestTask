//
//  Configurator.swift
//  Funbox
//
//  Created by Антон Кочетков on 27.11.2021.
//

import Foundation
import UIKit

class Configurator {
    
    static func configureTabBarController(frontProvider: StoreFrontProviderProtocol, backProvider: BackEndProviderProtocol) -> MainTabBarViewController {
        let backEnd = configureBackFront(provider: backProvider)
        
        let storeFront = configureStoreFront(provider: frontProvider)
        
        let tabBarController = MainTabBarViewController()
        
        tabBarController.setViewControllers([storeFront, backEnd], animated: true)
        
        return tabBarController
    }
    
    private static func configureStoreFront(provider: StoreFrontProviderProtocol) -> StorePageViewController {
        let pageController = StorePageViewController(provider: provider)
        configureTabBarItem(pageController.tabBarItem, title: "Store-front", tag: 0)
        return pageController
    }
    
    private static func configureBackFront(provider: BackEndProviderProtocol) -> UINavigationController {
        let backEndTable = BackEndViewController(provider: provider)
        
        let navController = UINavigationController(rootViewController: backEndTable)
        navController.navigationBar.backgroundColor = .systemGray4
        
        configureTabBarItem(navController.tabBarItem, title: "Back-End", tag: 1)
        return navController
    }
    
    
    private static func configureTabBarItem(_ tabBarItem: UITabBarItem, title: String, tag: Int) {
        tabBarItem.title = title
        tabBarItem.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 26)], for: .normal)
        tabBarItem.tag = tag
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -12)
    }
}
