//
//  File.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()

    let leftBackground = UIView()
    let rightBackground = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        
        leftBackground.translatesAutoresizingMaskIntoConstraints = false
        leftBackground.backgroundColor = UIColor.leftBackgroundColor
        
        rightBackground.translatesAutoresizingMaskIntoConstraints = false
        rightBackground.backgroundColor = UIColor.rightBackgroundColor

        paceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        paceLabel.textColor = UIColor.textColor
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        paceLabel.backgroundColor = UIColor.leftBackgroundColor

        raceLabel.font = UIFont.systemFont(ofSize: 20)
        raceLabel.textColor = UIColor.textColor
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        raceLabel.backgroundColor = UIColor.rightBackgroundColor

        contentView.addSubview(rightBackground)
        contentView.addSubview(leftBackground)
        contentView.addSubview(paceLabel)
        contentView.addSubview(raceLabel)
        
        NSLayoutConstraint.activate([
            leftBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftBackground.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            leftBackground.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            rightBackground.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            rightBackground.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            rightBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            paceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            raceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            paceLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor, constant: -12),
            raceLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 12)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
