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
        
    let tableView = UITableView()
    let header = PaceHeader()
    let footer = PaceFooter()

    // Local state
    var constraints = [NSLayoutConstraint]()
    var expanded = false
    var data: [CellData] = []
    var selectingDistance = false
    var customRace: CustomRace?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        if let raceState = Storage.loadRaceState() {
            store.dispatch(LoadRaceState(state: raceState))
        }

        super.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("Pace tables", comment: "Shows paces and finish times by race.")
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        navigationController?.isNavigationBarHidden = true

        setupTableView()
        setupHierarchy()
    }

    override func updateViewConstraints() {
        if constraints.isEmpty {
            constraints = [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: footer.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                footer.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                footer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -kSpacing * 2)
            ]
            NSLayoutConstraint.activate(constraints)
        }
        super.updateViewConstraints()
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

extension PaceViewController {
    func setupTableView() {
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 80;
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PaceCell.self, forCellReuseIdentifier: PaceCell.cellIdentifier)
        tableView.register(DistanceCell.self, forCellReuseIdentifier: DistanceCell.cellIdentifier)
        tableView.register(CustomDistanceCell.self, forCellReuseIdentifier: CustomDistanceCell.cellIdentifier)
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(footer)
    }
    
}

extension PaceViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {
        data = PaceController.buildCellData(with: state)
        expanded = state.navigationState.expanded()
        selectingDistance = state.navigationState.selectingDistance
        customRace = state.raceState.customRace
        // TODO: Fix this check — we shouldn't need to care about this here. Custom Race should move inside Race somehow, e.g. make Race a protocol.
        header.distanceLabel.text = state.raceState.race == .custom ? state.raceState.customRace?.distanceString() : state.raceState.race.longString
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

extension PaceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectingDistance ? PaceController.distanceData.count + 1 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (selectingDistance) {
            if (indexPath.row == PaceController.distanceData.count) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomDistanceCell.cellIdentifier) as? CustomDistanceCell else {
                    fatalError("The dequeued cell instance is incorrect.")
                }
                
                if let race = customRace {
                    cell.textField.text = race.distanceString()
                    cell.metric = race.metric
                    
                    if race.metric {
                        cell.unitSwitch.isOn = true
                        cell.unitLabel.text = race.unitString()
                    }
                }
                
                cell.selectionStyle = .none
                return cell
            }

            guard let cell = tableView.dequeueReusableCell(withIdentifier: DistanceCell.cellIdentifier) as? DistanceCell else {
                fatalError("The dequeued cell instance is incorrect.")
            }

            cell.distanceLabel.text = PaceController.distanceData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PaceCell.cellIdentifier) as? PaceCell else {
                fatalError("The dequeued cell instance is incorrect.")
            }
            
            cell.selectionStyle = .none
            cell.paceLabel.text = data[indexPath.row].pace.paceString()
            cell.raceLabel.text = data[indexPath.row].finishTime.finishTimeString()

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 13.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectingDistance && indexPath.row == PaceController.distanceData.count {
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
            }
        } else if (expanded) {
            store.dispatch(CollapsePaces())
        } else {
            store.dispatch(ExpandPaces(expansion: indexPath.row))
        }
    }
}

/*
 TODO: Implement force touch to show splits.
extension PaceViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        previewingContext.sourceRect = cell.frame
        
        let splitsController = SplitsViewController()
        splitsController.preferredContentSize = CGSize(width: 0.0, height: 300)
        return splitsController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: nil)
    }
}
*/
