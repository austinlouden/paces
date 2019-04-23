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
    
    var pace = paces(with: State())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
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
        
        cell.textLabel?.text = pace[indexPath.row]
        return cell
    }
}

