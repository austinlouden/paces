//
//  DistanceCell.swift
//  RacePace
//
//  Created by Austin Louden on 5/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import ReSwift
import UIKit

class DistanceCell: UITableViewCell {

    let distanceLabel = Label.titleLabel(with: "")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin + kSpacing)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomDistanceCell: UITableViewCell, UITextFieldDelegate {
    
    let textField = UITextField()
    let unitSwitch = UISwitch()
    let saveButton = Button.button(with: "Select")
    let unitLabel = Label.detailLabel(with: "miles")
    
    var metric = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("Custom", comment: "Choose a custom distance.")
        textField.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        textField.textColor = UIColor.textColor
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        contentView.addSubview(textField)
        
        unitLabel.isHidden = true
        contentView.addSubview(unitLabel)
        
        unitSwitch.translatesAutoresizingMaskIntoConstraints = false
        unitSwitch.onTintColor = UIColor.lightTextColor
        unitSwitch.isHidden = true
        unitSwitch.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        contentView.addSubview(unitSwitch)
        
        saveButton.isHidden = true
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        contentView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin + kSpacing),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kAppMargin),
            
            unitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: unitSwitch.leadingAnchor, constant: -kSpacing * 2),

            unitSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            unitSwitch.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -kSpacing * 2),
    
            saveButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kAppMargin)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func savePressed() {
        if let s = textField.text, let d = Double(s) {
            textField.resignFirstResponder()
            toggleHiddenUI()
            
            let customRace = CustomRace(distance: d, metric: metric)
            textField.text = customRace.distanceString()
            store.dispatch(SelectCustomRace(customRace: customRace))
            store.dispatch(ToggleDistanceSelector())
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
    
    @objc func toggleSwitch() {
        metric = !metric
        unitLabel.text = metric ? "kilometers" : "miles"
    }
    
    @objc func textFieldDidChange() {
        guard let text = textField.text else { return }

        if text.count > 6 {
            textField.text = String(text.dropLast())
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if (text.count > 3) {
            textField.text = String(text.dropLast(3))
        }

        toggleHiddenUI()
    }
    
    private func toggleHiddenUI() {
        saveButton.isHidden = !saveButton.isHidden
        unitSwitch.isHidden = !unitSwitch.isHidden
        unitLabel.isHidden = !unitLabel.isHidden
    }
}
