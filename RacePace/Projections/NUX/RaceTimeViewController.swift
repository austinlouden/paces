//
//  PriorRaceViewController.swift
//  RacePace
//
//  Created by Austin Louden on 5/29/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class RaceTimeViewController: UIViewController {
    
    let titleLabel = Label.titleLabel(with: NSLocalizedString("Your last race", comment: "The last race you ran in."))
    let detailLabel = Label.detailLabel(with: NSLocalizedString("Enter the finish time from your last competitive race.", comment: "The last race you ran in."))
    
    let hmsLabel = Label.detailLabel(with: "")
    
    let racePickerView = UIPickerView()
    let races = Race.allCases.map({ $0.longString })
    let times = Array(0...59).map{ String($0) }
    
    var race = Race.fiveK
    var hours = 0
    var minutes = 22
    var seconds = 12
    
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

        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        
        racePickerView.translatesAutoresizingMaskIntoConstraints = false
        racePickerView.dataSource = self
        racePickerView.delegate = self
        racePickerView.tag = 0
        racePickerView.selectRow(race.rawValue, inComponent: 0, animated: false) // half marathon
        view.addSubview(racePickerView)
        
        updateTimeText()
        hmsLabel.font = UIFont.boldSystemFont(ofSize: standardFontSize)
        view.addSubview(hmsLabel)
        
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.dataSource = self
        timePickerView.delegate = self
        timePickerView.tag = 1
        timePickerView.selectRow(hours, inComponent: 0, animated: false) // 1 hour
        timePickerView.selectRow(minutes, inComponent: 1, animated: false) // 46 minutes
        timePickerView.selectRow(seconds, inComponent: 2, animated: false) // 25 seconds
        view.addSubview(timePickerView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: appMargin * 2),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: appMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -appMargin),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            racePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            racePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            racePickerView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor),
            
            hmsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hmsLabel.topAnchor.constraint(equalTo: racePickerView.bottomAnchor, constant: spacing),

            timePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timePickerView.topAnchor.constraint(equalTo: hmsLabel.bottomAnchor, constant: spacing)
        ])
    }
    
    func updateTimeText() {
        hmsLabel.text = String.localizedStringWithFormat(NSLocalizedString("A %@ in %dH:%dM:%dS ",
                                                                           comment: "A race (e.g. a half marathon) in hours minutes and seconds (e.g. 1H:45M:25S)"),
                                                         race.longString.lowercased(), hours, minutes, seconds)
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
            return times[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            guard let race = Race(rawValue: row) else { assertionFailure(); return }
            self.race = race
        } else {
            if component == 0 {
                hours = row
            } else if component == 1 {
                minutes = row
            } else {
                seconds = row
            }
        }
        updateTimeText()
    }
    
}
