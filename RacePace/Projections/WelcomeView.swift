//
//  WelcomeView.swift
//  RacePace
//
//  Created by Austin Louden on 5/25/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    let welcomeLabel = Label.titleLabel(with: NSLocalizedString("Welcome!", comment: "Welcome"))
    let detailLabel = Label.detailLabel(with: NSLocalizedString("Enter a finish time from a previous race to calculate your training paces. " +
        "You can manually override any generated value if you choose to later.", comment: "Prompt to enter time from a previous race."))
    let getStartedButton = Button.button(with: "Get started")
    let bottomBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white

        addSubview(welcomeLabel)
        addSubview(detailLabel)

        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        addSubview(getStartedButton)
        
        bottomBorder.backgroundColor = UIColor.lightTextColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            
            detailLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: spacing),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            
            getStartedButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: spacing * 2),
            getStartedButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            getStartedButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),

            bottomBorder.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: spacing * 3),
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getStartedTapped() {
        reduce(action: .presentProjectionsNUX, state: appState)
    }
}
