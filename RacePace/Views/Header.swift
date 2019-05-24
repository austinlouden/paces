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

    let increaseButton = UIButton(type: .roundedRect)
    let decreaseButton = UIButton(type: .roundedRect)

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
        
        setupButton(with: increaseButton, increasing: true)
        setupButton(with: decreaseButton, increasing: false)
        increaseButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        addSubview(increaseButton)
        addSubview(decreaseButton)

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
            paceLabel.trailingAnchor.constraint(equalTo: decreaseButton.leadingAnchor, constant: -12),
            raceLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 12),
            
            // + button
            increaseButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -12),
            increaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            // - button
            decreaseButton.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -4),
            decreaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton(with button: UIButton, increasing: Bool) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.leftHeaderBackgroundColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8;
        
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.white.cgColor
        
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
