//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {

    static let height: CGFloat = 60.0
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()
    
    let leftBackground = UIView()
    let rightBackground = UIView()

    let tapRecognizer = UITapGestureRecognizer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        leftBackground.translatesAutoresizingMaskIntoConstraints = false
        leftBackground.backgroundColor = UIColor.leftHeaderBackgroundColor
        addSubview(leftBackground)
        
        rightBackground.translatesAutoresizingMaskIntoConstraints = false
        rightBackground.backgroundColor = UIColor.rightHeaderBackgroundColor
        addSubview(rightBackground)
    
        paceLabel.text = NSLocalizedString("Pace", comment: "The time per mile or km.")
        paceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        paceLabel.textColor = UIColor.white
        paceLabel.backgroundColor = UIColor.leftHeaderBackgroundColor
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paceLabel)

        raceLabel.text = appState.race.string
        raceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        raceLabel.textColor = UIColor.white
        raceLabel.backgroundColor = UIColor.rightHeaderBackgroundColor
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(raceLabel)

        tapRecognizer.addTarget(self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapRecognizer)

        NSLayoutConstraint.activate([
            leftBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftBackground.heightAnchor.constraint(equalTo: self.heightAnchor),
            leftBackground.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            
            rightBackground.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            rightBackground.heightAnchor.constraint(equalTo: self.heightAnchor),
            rightBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            paceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            raceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            paceLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -12),
            raceLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 12)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerTapped() {
        _ = reduce(action: .toggleDistanceSelection, state: appState)
    }
    
}
