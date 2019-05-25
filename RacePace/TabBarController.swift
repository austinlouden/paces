//
//  TabBarController.swift
//  RacePace
//
//  Created by Austin Louden on 5/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        tabBar.isTranslucent = false

        let viewController = ViewController()
        let projections = ProjectionsViewController()
        
        projections.tabBarItem = UITabBarItem(title: "Your paces", image: nil, selectedImage: nil)
        viewController.tabBarItem = UITabBarItem(title: "Race tables", image: nil, selectedImage: nil)
        
        viewControllers = [projections, viewController]
    }
}
