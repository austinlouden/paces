//
//  Projections.swift
//  RacePace
//
//  Created by Austin Louden on 5/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

struct TrainingPace {
    let name: String
    let pace: Pace?
}


class ProjectionsViewController: UIViewController {
    
    let tableView = UITableView()
    let welcomeView = WelcomeView()
    let segmentedControl = UISegmentedControl(items: ["Training", "Race", "Goal"])
    var data = [TrainingPace]()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        welcomeView.clipsToBounds = true
        welcomeView.layer.cornerRadius = 8;
        view.addSubview(welcomeView)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        view.addSubview(segmentedControl)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TrainingPaceCell.self, forCellReuseIdentifier: "projectionCellIdentifier")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: appMargin * 2),
            welcomeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: appMargin),
            welcomeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -appMargin),

            segmentedControl.topAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: spacing * 4),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: appMargin),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -appMargin),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: spacing * 2),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // add example data
        data.append(TrainingPace(name: "Easy", pace: Pace(minutes: 10, seconds: 51)))
        data.append(TrainingPace(name: "Tempo", pace: nil))
        data.append(TrainingPace(name: "Lactate Threshold", pace: nil))
        data.append(TrainingPace(name: "VO₂ Max", pace: Pace(minutes: 6, seconds: 51)))
        data.append(TrainingPace(name: "Long", pace: nil))
        data.append(TrainingPace(name: "Speed", pace: Pace(minutes: 8, seconds: 51)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    @objc func indexChanged(sender: UISegmentedControl) {
        print("TODO: change")
    }
}

extension ProjectionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectionCellIdentifier") as? TrainingPaceCell else {
            fatalError("The dequeued cell instance is incorrect.")
        }

        cell.selectionStyle = .none
        cell.nameLabel.text = data[indexPath.row].name
        
        if let pace = data[indexPath.row].pace {
            cell.paceLabel.text = pace.paceString()
        } else {
            cell.paceLabel.text = NSLocalizedString("Not set", comment: "Not set")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}
