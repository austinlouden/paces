//
//  ViewController.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class PaceViewController: UIViewController {
    
    let tableView = UITableView()
    let header = Header()
    let footer = Footer()

    // Local state
    var data: [CellData]
    let distanceData = Race.allCases.map({ $0.longString }).dropLast() // don't include the custom race cell
    var expanded = false
    var selectingDistance = false

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        reduce(action: .loadSettings, state: appState)
        reduce(action: .loadCustomRace, state: appState)
        data = buildCellData(with: appState)
        super.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("Pace tables", comment: "Shows paces and finish times by race.")
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
    
    @objc func stateDidChange(_ notification:Notification) {
        guard let action = notification.object as? Action else { return }
        
        switch action {
        case .selectCustomRace:
            tableView(tableView, didSelectRowAt: IndexPath(row: distanceData.count, section: 0))
        case .selectRace:
            data = buildCellData(with: appState)
            tableView.reloadData()
        case .toggleDistanceSelection:
            selectingDistance = appState.selectingDistance
            footer.isHidden = !footer.isHidden
            expanded = false
            tableView.reloadData()
        case .toggleExpansion:
            expanded = appState.expanded
            footer.increaseButton.isHidden = !footer.increaseButton.isHidden
            footer.decreaseButton.isHidden = !footer.decreaseButton.isHidden
            tableView.reloadData()
        case .incrementPace:
            fallthrough
        case .decrementPace:
            data = buildCellData(with: appState)
            tableView.reloadData()
        default:
            break
        }
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
            
            /* HIDE TAGS FOR THIS VERSION
            if (data[indexPath.row].tags.count > 0 && appState.race == .marathon) {
                cell.tagButton.setTitle(data[indexPath.row].tags[0], for: .normal)
                cell.tagButton.isHidden = false
            }
            */
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html#//apple_ref/doc/uid/TP40007451-CH10-SW9
        
        if (selectingDistance) {
            if let race = Race(rawValue: indexPath.row) {
                header.distanceLabel.text = race.longString
                reduce(action: .toggleDistanceSelection, state: appState)
                reduce(action: .selectRace(race: race), state: appState)
            }
        } else if (expanded) {
            let firstRow = IndexPath(row: 0, section: 0)
            let lastRow = IndexPath(row: data.count - 1, section: 0)
    
            let indexPathsToDelete = tableView.visibleCells
                .compactMap { tableView.indexPath(for: $0) }
                .filter { $0 != firstRow && $0 != lastRow }
            
             data = buildCellData(with: appState)
            
            let newLastRow = IndexPath(row: data.count - 1, section: 0)
            
            let indexPathsToAdd = [Int](1 ..< data.count - 1).map {
                IndexPath(row: $0, section: 0)
            }

            tableView.beginUpdates()
            tableView.deleteRows(at: indexPathsToDelete, with: .fade)
            tableView.insertRows(at: indexPathsToAdd, with: .fade)
            tableView.endUpdates()
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [firstRow, newLastRow], with: .fade)
            tableView.endUpdates()
            
            reduce(action: .toggleExpansion, state: appState)
        } else {
            let currentCell = data[indexPath.row]
            guard let currentRow = tableView.indexPathForSelectedRow else { return }
            
            // selected the last cell
            if (indexPath.row == data.count - 1) {
                data.removeAll { $0 != currentCell }

                let indexPathsToDelete = tableView.visibleCells
                    .compactMap { tableView.indexPath(for: $0) }
                    .filter { $0 != currentRow }

                updateIntervalTable(indexPathsToDelete)
            } else {
                let nextCell = data[indexPath.row + 1]
                data.removeAll { $0 != currentCell && $0 != nextCell }
                
                let nextRow = IndexPath(row: currentRow.row + 1, section: 0)
                let indexPathsToDelete = tableView.visibleCells
                    .compactMap { tableView.indexPath(for: $0) }
                    .filter { $0 != currentRow && $0 != nextRow }

                updateIntervalTable(indexPathsToDelete)
            }
            
            reduce(action: .toggleExpansion, state: appState)
        }
    }
    
    func updateIntervalTable(_ indexPathsToRemove: [IndexPath]) {
        data = buildIntervalCellData(with: data, state: appState)
        let offset = data.count == 6 ? 1 : 0
  
        let indexPathsToAdd = [Int](1 ..< data.count - offset).map {
            IndexPath(row: $0, section: 0)
        }

        tableView.beginUpdates()
        tableView.deleteRows(at: indexPathsToRemove, with: .fade)
        tableView.insertRows(at: indexPathsToAdd, with: .fade)
        tableView.endUpdates()
    }
}

