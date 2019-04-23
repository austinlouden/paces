//
//  ViewController.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()

    let pace: [String]
    let finish: [String]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pace = paces(with: appState)
        finish = finishTimes(with: appState)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        tableView.tableHeaderView = Header(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: Header.height))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cellIdentifier")
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? Cell else {
            fatalError("The dequeued cell instance is incorrect.")
        }
        
        cell.textLabel?.text = "\(pace[indexPath.row]) \(finish[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.bounds.size.height - Header.height) / 12.0
    }
}

