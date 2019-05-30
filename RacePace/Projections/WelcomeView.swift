//
//  WelcomeView.swift
//  RacePace
//
//  Created by Austin Louden on 5/25/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let getStartedButton = UIButton()
    let bottomBorder = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        titleLabel.text = NSLocalizedString("Welcome!", comment: "Welcome")
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.textColor
        titleLabel.backgroundColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        detailLabel.text = NSLocalizedString("Enter a finish time from a previous race to calculate your training paces. " +
            "You can manually override any generated value if you choose to later.", comment: "Prompt to enter time from a previous race.")
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor.mediumTextColor
        detailLabel.backgroundColor = UIColor.white
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailLabel)

        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.backgroundColor = UIColor.lightTextColor
        getStartedButton.setTitleColor(UIColor.textColor, for: .normal)
        getStartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        getStartedButton.setTitle("Get started", for: .normal)
        getStartedButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing * 2, bottom: 0, right: spacing * 2)
        getStartedButton.clipsToBounds = true
        getStartedButton.layer.cornerRadius = cornerRadius;
        addSubview(getStartedButton)
        
        bottomBorder.backgroundColor = UIColor.lightTextColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
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
