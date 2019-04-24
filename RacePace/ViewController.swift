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

    // TODO: make this into an array of one object
    var pace: [String]
    var finish: [String]
    
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
        view.backgroundColor = UIColor.white

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = Header(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: Header.height))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cellIdentifier")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? Cell else {
            fatalError("The dequeued cell instance is incorrect.")
        }

        cell.paceLabel.text = pace[indexPath.row]
        cell.raceLabel.text = finish[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.bounds.size.height - Header.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 12.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html#//apple_ref/doc/uid/TP40007451-CH10-SW9

        let currentPace = pace[indexPath.row]
        let nextPace = pace[indexPath.row + 1]
        
        let currentFinish = finish[indexPath.row]
        let nextFinish = finish[indexPath.row + 1]
        
        pace.removeAll { $0 != currentPace && $0 != nextPace }
        finish.removeAll { $0 != currentFinish && $0 != nextFinish }
        
        guard let currentRow = tableView.indexPathForSelectedRow else { return }
        let nextRow = IndexPath(row: currentRow.row + 1, section: 0)

        let indexPaths = tableView.visibleCells
            .compactMap { tableView.indexPath(for: $0) }
            .filter { $0 != currentRow && $0 != nextRow }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: .none)
        tableView.endUpdates()
        
    }
}

