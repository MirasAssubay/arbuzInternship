//
//  MainTabBarController.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 18.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: BasketViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "basket")
        
        
        vc1.title = "Главная"
        vc2.title = "Корзина"
//        vc3.title = "Profile"
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
}
