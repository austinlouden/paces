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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white

        paceLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width/2.0, height: frame.size.height)
        paceLabel.font = UIFont.boldSystemFont(ofSize: 18)

        raceLabel.frame = CGRect(x: frame.size.width/2.0, y: 0, width: frame.size.width/2.0, height: frame.size.height)
        raceLabel.font = UIFont.systemFont(ofSize: 18)

        addSubview(paceLabel)
        addSubview(raceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
