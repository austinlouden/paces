//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {

    static let height: CGFloat = 80.0
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        paceLabel.text = NSLocalizedString("Pace", comment: "The time per mile or km.")
        paceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        paceLabel.backgroundColor = UIColor.white
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paceLabel)

        raceLabel.text = headerText(with: appState)
        raceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        raceLabel.backgroundColor = UIColor.white
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(raceLabel)

        NSLayoutConstraint.activate([
            paceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            raceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            paceLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 10),
            raceLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
