//
//  SettingsViewController.swift
//  RacePace
//
//  Created by Austin Louden on 8/27/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  let tableView = UITableView()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nil, bundle: nil)
      self.title = NSLocalizedString("Settings", comment: "Settings")
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.systemBackground
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
