//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {
    let paceLabel = Label.titleLabel(with: "Pace")
    let paceDetailLabel = Label.detailLabel(with: "mi/min")
    let distanceLabel = Label.titleLabel(with: "")
    let distanceDetailLabel = Label.detailLabel(with: "Finish time")
    let tapRecognizer = UITapGestureRecognizer()
    let bottomBorder = UIView()

    let increaseButton = Button.button(with: "+1m")
    let decreaseButton = Button.button(with: "-1m")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white

        paceLabel.font = UIFont.boldSystemFont(ofSize: extraLargeFontSize)
        addSubview(paceLabel)

        distanceLabel.font = UIFont.boldSystemFont(ofSize: extraLargeFontSize)
        distanceLabel.textColor = UIColor.mediumTextColor
        addSubview(distanceLabel)
        
        addSubview(paceDetailLabel)
        addSubview(distanceDetailLabel)
    
        tapRecognizer.addTarget(self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapRecognizer)

        NSLayoutConstraint.activate([
            paceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: kSpacing),
            paceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kAppMargin),
            
            paceDetailLabel.topAnchor.constraint(equalTo: paceLabel.bottomAnchor, constant: 0),
            paceDetailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kAppMargin),
    
            distanceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: kSpacing),
            distanceLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: kSpacing),
            
            distanceDetailLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 0),
            distanceDetailLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: kSpacing),
            
            distanceDetailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -kSpacing)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerTapped() {
        if appState.selectingDistance {
            reduce(action: .closeDistanceSelection, state: appState)
        } else {
            reduce(action: .openDistanceSelection, state: appState)
        }
    }
    
}
