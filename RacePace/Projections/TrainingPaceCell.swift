//
//  TrainingPaceCell.swift
//  RacePace
//
//  Created by Austin Louden on 5/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class TrainingPaceCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let paceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = UIColor.textColor
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = UIColor.white
        contentView.addSubview(nameLabel)
        
        paceLabel.font = UIFont.systemFont(ofSize: 14)
        paceLabel.textColor = UIColor.textColor
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        paceLabel.backgroundColor = UIColor.white
        contentView.addSubview(paceLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing * 2),
            paceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing * 2),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: appMargin + spacing),
            paceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: spacing)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
