//
//  PriorRaceViewController.swift
//  RacePace
//
//  Created by Austin Louden on 5/29/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class RaceTimeViewController: UIViewController {
    
    let racePickerView = UIPickerView()
    let races = Race.allCases.map({ $0.longString })
    
    let timePickerView = UIPickerView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        racePickerView.translatesAutoresizingMaskIntoConstraints = false
        racePickerView.dataSource = self
        racePickerView.delegate = self
        racePickerView.tag = 0
        view.addSubview(racePickerView)
        
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.dataSource = self
        timePickerView.delegate = self
        timePickerView.tag = 1
        view.addSubview(timePickerView)
        
        NSLayoutConstraint.activate([
            racePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            racePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            racePickerView.bottomAnchor.constraint(equalTo: view.centerYAnchor),

            timePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timePickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RaceTimeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView.tag == 0 ? 1 : 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return races.count
        } else {
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return races[row]
        } else {
            return Array(0...59).map{ String($0) }[row]
        }
    }
    
}
