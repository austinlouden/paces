//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {

    //static let height: CGFloat = 72.0
    
    let paceLabel = Label.titleLabel(with: "Pace")
    let distanceLabel = Label.titleLabel(with: "")
    let tapRecognizer = UITapGestureRecognizer()
    let bottomBorder = UIView()

    let increaseButton = Button.button(with: "+1m")
    let decreaseButton = Button.button(with: "-1m")

    override init(frame: CGRect) {
        super.init(frame: frame)

        paceLabel.font = UIFont.boldSystemFont(ofSize: extraLargeFontSize)
        addSubview(paceLabel)

        distanceLabel.font = UIFont.boldSystemFont(ofSize: extraLargeFontSize)
        distanceLabel.textColor = UIColor.mediumTextColor
        addSubview(distanceLabel)
    
        tapRecognizer.addTarget(self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapRecognizer)

        NSLayoutConstraint.activate([
            paceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: kAppMargin),
            paceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kAppMargin + kSpacing),
    
            distanceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: kAppMargin),
            distanceLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: kSpacing),
            
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -kSpacing)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerTapped() {
        reduce(action: .toggleDistanceSelection, state: appState)
    }
    
}
