//
//  DistanceCell.swift
//  RacePace
//
//  Created by Austin Louden on 5/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

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
    let saveButton = Button.button(with: "Save")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("Custom distance (miles)", comment: "Choose a custom distance in miles.")
        textField.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        textField.textColor = UIColor.textColor
        textField.keyboardType = .decimalPad
        textField.delegate = self
        contentView.addSubview(textField)
        
        saveButton.isHidden = true
        contentView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin + kSpacing),
            textField.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -kSpacing),
            
            saveButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kAppMargin)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.count > 0 && saveButton.isHidden {
                saveButton.isHidden = false
            }
            
        }
        return true
    }
}
