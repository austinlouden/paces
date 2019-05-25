//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {

    static let height: CGFloat = 72.0
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()
    let distanceLabel = UILabel()
    let tapRecognizer = UITapGestureRecognizer()
    let bottomBorder = UIView()

    let increaseButton = UIButton(type: .roundedRect)
    let decreaseButton = UIButton(type: .roundedRect)

    override init(frame: CGRect) {
        super.init(frame: frame)

        paceLabel.text = NSLocalizedString("PACE", comment: "The time per mile or km.")
        paceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        paceLabel.textColor = UIColor.textColor
        paceLabel.backgroundColor = UIColor.white
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paceLabel)

        raceLabel.text = NSLocalizedString("FINISH TIME", comment: "The time it takes to complete the race.")
        raceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        raceLabel.textColor = UIColor.textColor
        raceLabel.backgroundColor = UIColor.white
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(raceLabel)
        
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        distanceLabel.textColor = UIColor.mediumTextColor
        distanceLabel.backgroundColor = UIColor.white
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(distanceLabel)
    
        setupButton(with: increaseButton, increasing: true)
        setupButton(with: decreaseButton, increasing: false)
        increaseButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        addSubview(increaseButton)
        addSubview(decreaseButton)

        bottomBorder.backgroundColor = UIColor.lightTextColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)

        tapRecognizer.addTarget(self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapRecognizer)

        NSLayoutConstraint.activate([            
            paceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            raceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            paceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: appMargin + spacing),
            raceLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: spacing * 2),
            distanceLabel.leadingAnchor.constraint(equalTo: raceLabel.trailingAnchor, constant: spacing),
            
            // + button
            increaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -appMargin),
            increaseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing),

            // - button
            decreaseButton.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -spacing),
            decreaseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing),
            
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 2),
            bottomBorder.trailingAnchor.constraint(equalTo: raceLabel.trailingAnchor, constant: spacing),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: appMargin)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton(with button: UIButton, increasing: Bool) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.textColor.cgColor
        
        if (increasing) {
            button.setTitle("+", for: .normal)
        } else {
            button.setTitle("-", for: .normal)
        }
    }

    @objc func increment() {
        // TODO: make these buttons work in the expanded state
        if (!appState.expanded) {
            _ = reduce(action: .incrementPace, state: appState)
        }
    }
    
    @objc func decrement() {
        if (!appState.expanded) {
            _ = reduce(action: .decrementPace, state: appState)
        }
    }
    
    @objc func headerTapped() {
        _ = reduce(action: .toggleDistanceSelection, state: appState)
    }
    
}
