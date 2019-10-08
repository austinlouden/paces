//
//  PaceDetailViewController.swift
//  RacePace
//
//  Created by Austin Louden on 10/7/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class PaceDetailViewController: UIViewController {
    
    init(pace:Pace, race: Race) {
        super.init(nibName: nil, bundle: nil)
        title = "\(pace.paceString()) \(race.longString)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
