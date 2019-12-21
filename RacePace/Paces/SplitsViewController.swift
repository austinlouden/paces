//
//  SplitsViewController.swift
//  RacePace
//
//  Created by Austin Louden on 12/21/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class SplitsViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
}
