//
//  DistanceCell.swift
//  RacePace
//
//  Created by Austin Louden on 5/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class DistanceCell: UITableViewCell {

    let distanceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white

        distanceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        distanceLabel.textColor = UIColor.white
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.backgroundColor = UIColor.leftBackgroundColor
        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            distanceLabel.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor, constant: -12),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
