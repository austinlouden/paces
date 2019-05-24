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
    let tagLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white

        paceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        paceLabel.textColor = UIColor.textColor
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        paceLabel.backgroundColor = UIColor.leftBackgroundColor

        raceLabel.font = UIFont.systemFont(ofSize: 18)
        raceLabel.textColor = UIColor.textColor
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        raceLabel.backgroundColor = UIColor.rightBackgroundColor
        
        tagLabel.font = UIFont.systemFont(ofSize: 14)
        tagLabel.textColor = UIColor.textColor
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.backgroundColor = UIColor.rightBackgroundColor

        contentView.addSubview(paceLabel)
        contentView.addSubview(raceLabel)
        contentView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            paceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            raceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            paceLabel.trailingAnchor.constraint(equalTo: raceLabel.leadingAnchor, constant: -8),
            raceLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -12),
            
            tagLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 12),
            tagLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagLabel.text = ""
    }
}
