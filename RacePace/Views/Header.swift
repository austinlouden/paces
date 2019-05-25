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

        raceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        raceLabel.textColor = UIColor.textColor
        raceLabel.backgroundColor = UIColor.white
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(raceLabel)
    
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

            paceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: appMargin + spacing),
            raceLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: spacing * 2),
            
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
        _ = reduce(action: .incrementPace, state: appState)
    }
    
    @objc func decrement() {
        _ = reduce(action: .decrementPace, state: appState)
    }
    
    @objc func headerTapped() {
        _ = reduce(action: .toggleDistanceSelection, state: appState)
    }
    
}
