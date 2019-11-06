//
//  ViewController.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import ReSwift
import UIKit

class PaceViewController: UIViewController {
    
    var expanded = false
    
    let tableView = UITableView()
    let header = Header()
    let footer = Footer()

    // Local state
    var data: [CellData] = []
    let distanceData = Race.allCases.map({ $0.longString }).dropLast() // don't include the custom race cell
    var selectingDistance = false
    var customRace: CustomRace?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        if let raceState = Storage.loadRaceState() {
            store.dispatch(LoadRaceState(state: raceState))
        }

        super.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("Pace tables", comment: "Shows paces and finish times by race.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        header.distanceLabel.text = appState.race.longString

        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 80;
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.register(DistanceCell.self, forCellReuseIdentifier: "distanceCellIdentifier")
        tableView.register(CustomDistanceCell.self, forCellReuseIdentifier: "customDistanceCellIdentifier")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
        super.viewWillDisappear(animated)
    }
}

extension PaceViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {
        data = buildCellData(with: data, state: state)
        expanded = state.navigationState.expanded
        selectingDistance = state.navigationState.selectingDistance
        customRace = state.raceState.customRace
        // TODO: Fix this check — we shouldn't need to care about this here. Custom Race should move inside Race somehow, e.g. make Race a protocol.
        header.distanceLabel.text = state.raceState.race == .custom ? state.raceState.customRace?.distanceString() : state.raceState.race.longString
        tableView.reloadData()
    }
}

extension PaceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectingDistance ? distanceData.count + 1 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (selectingDistance) {
            if (indexPath.row == distanceData.count) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "customDistanceCellIdentifier") as? CustomDistanceCell else {
                    fatalError("The dequeued cell instance is incorrect.")
                }
                
                if let race = customRace {
                    cell.textField.text = race.distanceString()
                    
                    if race.metric {
                        cell.unitSwitch.isOn = true
                        cell.unitLabel.text = race.unitString()
                    }
                }
                
                cell.selectionStyle = .none
                return cell
            }

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "distanceCellIdentifier") as? DistanceCell else {
                fatalError("The dequeued cell instance is incorrect.")
            }

            cell.distanceLabel.text = distanceData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? Cell else {
                fatalError("The dequeued cell instance is incorrect.")
            }
            
            cell.selectionStyle = .none
            cell.paceLabel.text = data[indexPath.row].pace.paceString()
            cell.raceLabel.text = data[indexPath.row].finishTime.finishTimeString()

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.bounds.size.height - 100 - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 12.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footer
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectingDistance && indexPath.row == distanceData.count {
            return nil
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectingDistance) {
            if let race = Race(rawValue: indexPath.row) {
                header.distanceLabel.text = race.longString
                store.dispatch(ToggleDistanceSelector())
                store.dispatch(SelectRace(race: race))
            } else {
                print("couldnt create race")
            }
        } else if (expanded) {
            store.dispatch(CollapsePaces())
        } else {
            // table is in the default, collapsed state
            let currentCell = data[indexPath.row]

            // selected the last cell
            if (indexPath.row == data.count - 1) {
                data.removeAll { $0 != currentCell }
            } else {
                let nextCell = data[indexPath.row + 1]
                data.removeAll { $0 != currentCell && $0 != nextCell }
            }

            store.dispatch(ExpandPaces())
        }
    }
    
}

