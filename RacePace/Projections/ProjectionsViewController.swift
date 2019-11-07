//
//  Projections.swift
//  RacePace
//
//  Created by Austin Louden on 5/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class ProjectionsViewController: UIViewController {
    
    let tableView = UITableView()
    let welcomeView = WelcomeView()
    let projectionsView = ProjectionsView()
    let segmentedControl = UISegmentedControl(items: ["Training", "Predictions", "Goal"])

    var trainingData = [Pace]()
    var predictionData = [Event]()
    var goalData = [Event]()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("Your paces", comment: "Tab to store and generate paces")
        NotificationCenter.default.addObserver(self, selector: #selector(stateDidChange(_:)), name: .stateDidChange, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .stateDidChange, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        welcomeView.isHidden = false
        view.addSubview(welcomeView)
        
        projectionsView.translatesAutoresizingMaskIntoConstraints = false
        projectionsView.isHidden = true
        view.addSubview(projectionsView)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.textColor
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TrainingPaceCell.self, forCellReuseIdentifier: "projectionCellIdentifier")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: kAppMargin),
            welcomeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: kAppMargin),
            welcomeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -kAppMargin),
            
            projectionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: kAppMargin),
            projectionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: kAppMargin),
            projectionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -kAppMargin),
            projectionsView.heightAnchor.constraint(equalTo: welcomeView.heightAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: kSpacing * 4),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kAppMargin),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kAppMargin),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: kSpacing * 2),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reduce(action: .getRaces, state: appState)

        /*
        if let lastRace = appState.lastRace, let goalRace = appState.goalRace {
            welcomeView.isHidden = true

            projectionsView.lastTimeLabel.text = "\(lastRace.time.finishTimeString()) \(lastRace.race.longString)"
            projectionsView.goalTimeLabel.text = "\(goalRace.time.finishTimeString()) \(goalRace.race.longString)"
            projectionsView.isHidden = false
            
            // TODO: Don't put this in view will appear
            trainingData = PaceCalculator.calculatePaces(with: lastRace)
            predictionData = PaceCalculator.calculateRaces(with: lastRace)
            goalData = PaceCalculator.calculateRaces(with: goalRace)
            self.tableView.reloadData()
            
        }
         */
    }
    
    @objc func stateDidChange(_ notification:Notification) {
        guard let action = notification.object as? AnAction else {
            return
        }
        
        if action == .presentProjectionsNUX {
            navigationController?.present(UINavigationController(rootViewController: LastRaceViewController()), animated: true, completion: nil)
        }
    }
    
    @objc func indexChanged(sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}

extension ProjectionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return trainingData.count
        } else {
            return predictionData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectionCellIdentifier") as? TrainingPaceCell else {
            fatalError("The dequeued cell instance is incorrect.")
        }

        cell.selectionStyle = .none
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            cell.nameLabel.text = trainingData[indexPath.row].name
            cell.paceLabel.text = trainingData[indexPath.row].paceString()
        } else if (segmentedControl.selectedSegmentIndex == 1) {
            cell.nameLabel.text = predictionData[indexPath.row].race.longString
            cell.paceLabel.text = predictionData[indexPath.row].time.finishTimeString()
        } else if (segmentedControl.selectedSegmentIndex == 2) {
            cell.nameLabel.text = goalData[indexPath.row].race.longString
            cell.paceLabel.text = goalData[indexPath.row].time.finishTimeString()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}
