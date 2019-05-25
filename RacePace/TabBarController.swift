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
        let viewController = ViewController()
        let projections = ProjectionsViewController()
        
        projections.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        viewControllers = [projections, viewController]
    }
}
