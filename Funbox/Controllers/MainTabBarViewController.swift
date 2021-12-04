//
//  MainTabBarViewController.swift
//  Funbox
//
//  Created by Антон Кочетков on 28.11.2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        delegate = self
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.barTintColor = .systemGray4
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .systemGray4
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let storePage = viewController as? StorePageViewController {
            storePage.updateContent()
        } else if let navContr = viewController as? UINavigationController {
            guard let backEnd = navContr.viewControllers.first as? BackEndViewController else { return }
            backEnd.updateContent()
        }
    }
}
