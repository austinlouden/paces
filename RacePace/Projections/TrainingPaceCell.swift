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
    let descriptionLabel = Label.detailLabel(with: "The key to a long run is the distance, not the pace. For experienced runners, this should be 30 to 90 seconds slower per mile than your goal race pace.")
    
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
        
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kSpacing * 2),
            paceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kSpacing * 2),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin),
            paceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: kSpacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: kSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kAppMargin),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -kSpacing)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
