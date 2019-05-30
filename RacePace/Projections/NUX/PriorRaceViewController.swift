//
//  PriorRaceViewController.swift
//  RacePace
//
//  Created by Austin Louden on 5/29/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class PriorRaceViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
}
