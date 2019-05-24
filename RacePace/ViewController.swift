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
    let increaseButton = UIButton(type: .roundedRect)
    let decreaseButton = UIButton(type: .roundedRect)

    let buttonHeight: CGFloat = 256.0

    let leftTopBackground = UIView()
    let rightTopBackground = UIView()
    let leftBottomBackground = UIView()
    let rightBottomBackground = UIView()
    
    let header = Header()

    // Local state
    var data: [CellData]
    let distanceData = Race.allCases.map({ $0.string })
    var expanded = false
    var selectingDistance = false
    var pace = 7
    var race = Race.marathon

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        data = buildCellData(with: appState)
        super.init(nibName: nil, bundle: nil)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(stateDidChange(_:)), name: .stateDidChange, object: nil)
        
        // backgrounds
        leftTopBackground.translatesAutoresizingMaskIntoConstraints = false
        rightTopBackground.translatesAutoresizingMaskIntoConstraints = false
        leftBottomBackground.translatesAutoresizingMaskIntoConstraints = false
        rightBottomBackground.translatesAutoresizingMaskIntoConstraints = false
        leftTopBackground.backgroundColor = UIColor.leftHeaderBackgroundColor
        rightTopBackground.backgroundColor = UIColor.rightHeaderBackgroundColor
        leftBottomBackground.backgroundColor = UIColor.leftBackgroundColor
        rightBottomBackground.backgroundColor = UIColor.rightBackgroundColor
        view.addSubview(leftTopBackground)
        view.addSubview(rightTopBackground)
        view.addSubview(leftBottomBackground)
        view.addSubview(rightBottomBackground)
        
        header.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: Header.height)
        header.raceLabel.text = appState.race.string

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = header
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.register(DistanceCell.self, forCellReuseIdentifier: "distanceCellIdentifier")
        view.addSubview(tableView)
        
        setupButton(with: increaseButton, increasing: true)
        setupButton(with: decreaseButton, increasing: false)
        increaseButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        view.addSubview(increaseButton)
        view.addSubview(decreaseButton)

        NSLayoutConstraint.activate([
            // backgrounds
            leftTopBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftTopBackground.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            leftTopBackground.topAnchor.constraint(equalTo: view.topAnchor),
            leftTopBackground.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            leftBottomBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftBottomBackground.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            leftBottomBackground.topAnchor.constraint(equalTo: view.centerYAnchor),
            leftBottomBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rightTopBackground.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            rightTopBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightTopBackground.topAnchor.constraint(equalTo: view.topAnchor),
            rightTopBackground.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            rightBottomBackground.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            rightBottomBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightBottomBackground.topAnchor.constraint(equalTo: view.centerYAnchor),
            rightBottomBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // table
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // + button
            increaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            increaseButton.widthAnchor.constraint(equalToConstant: increaseButton.titleLabel!.intrinsicContentSize.width + 8.0 * 2.0),
            increaseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Header.height/2.0),
            increaseButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            // - button
            decreaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            decreaseButton.widthAnchor.constraint(equalToConstant: increaseButton.titleLabel!.intrinsicContentSize.width + 8.0 * 2.0),
            decreaseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Header.height/2.0),
            decreaseButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc func stateDidChange(_ notification:Notification) {
        if (selectingDistance != appState.selectingDistance) {
            selectingDistance = appState.selectingDistance
            expanded = false
            toggleButtonVisibility()
            tableView.reloadData()
        } else if (expanded != appState.expanded) {
            expanded = appState.expanded
            toggleButtonVisibility()
            tableView.reloadData()
        } else if (pace != appState.pace) {
            pace = appState.pace
            tableView.reloadData()
        } else if (race != appState.race) {
            race = appState.race
            header.raceLabel.text = race.string
            data = buildCellData(with: appState)
            tableView.reloadData()
        }
    }
    
    func setupButton(with button: UIButton, increasing: Bool) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.buttonColor
        button.setTitleColor(UIColor.textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20

        if (increasing) {
            button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            button.setTitle("+1m", for: .normal)
        } else {
            button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            button.setTitle("-1m", for: .normal)
        }
    }
    
    func toggleButtonVisibility() {
        if (!expanded && !selectingDistance) {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.decreaseButton.transform = .identity
                self.increaseButton.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.decreaseButton.transform = CGAffineTransform(translationX: -self.decreaseButton.frame.width, y: 0)
                self.increaseButton.transform = CGAffineTransform(translationX: self.increaseButton.frame.width, y: 0)
            }
        }
    }

    @objc func increment() {
        data = buildCellData(with: reduce(action: .incrementPace, state: appState))
    }

    @objc func decrement() {
        data = buildCellData(with: reduce(action: .decrementPace, state: appState))
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectingDistance ? distanceData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (selectingDistance) {
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
            cell.paceLabel.text = data[indexPath.row].paceString()
            cell.raceLabel.text = data[indexPath.row].finishTimeString()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.bounds.size.height - Header.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 12.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html#//apple_ref/doc/uid/TP40007451-CH10-SW9
        
        if (selectingDistance) {
            if let race = Race(rawValue: indexPath.row) {
                _ = reduce(action: .toggleDistanceSelection, state: appState)
                _ = reduce(action: .selectRace(race: race), state: appState)
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
            
            _ = reduce(action: .toggleExpansion, state: appState)
        } else {
            // TODO: handle case where the last cell is tapped
            let currentCell = data[indexPath.row]
            let nextCell = data[indexPath.row + 1]
            data.removeAll { $0 != currentCell && $0 != nextCell }
            data = buildIntervalCellData(with: data, state: appState)
            
            guard let currentRow = tableView.indexPathForSelectedRow else { return }
            let nextRow = IndexPath(row: currentRow.row + 1, section: 0)
            
            let indexPathsToDelete = tableView.visibleCells
                .compactMap { tableView.indexPath(for: $0) }
                .filter { $0 != currentRow && $0 != nextRow }
            
            let indexPathsToAdd = [Int](1 ..< data.count - 1).map {
                IndexPath(row: $0, section: 0)
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPathsToDelete, with: .fade)
            tableView.insertRows(at: indexPathsToAdd, with: .fade)
            tableView.endUpdates()
            
            _ = reduce(action: .toggleExpansion, state: appState)
        }
    }
}

