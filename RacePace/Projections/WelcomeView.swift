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
    
    let raceLabel = UILabel()
    let finishLabel = UILabel()
    
    let raceSelectButton = UIButton()
    
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
        
        detailLabel.text = NSLocalizedString("Enter a time from a previous race to calculate your training paces. " +
            "You can manually override any generated value if you choose to later.", comment: "Prompt to enter time from a previous race.")
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor.mediumTextColor
        detailLabel.backgroundColor = UIColor.white
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailLabel)
        
        raceLabel.text = NSLocalizedString("Race", comment: "Race")
        raceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        raceLabel.textColor = UIColor.textColor
        raceLabel.backgroundColor = UIColor.white
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(raceLabel)
        
        finishLabel.text = NSLocalizedString("Finish time", comment: "Finish time")
        finishLabel.font = UIFont.boldSystemFont(ofSize: 14)
        finishLabel.textColor = UIColor.textColor
        finishLabel.backgroundColor = UIColor.white
        finishLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(finishLabel)
        
        raceSelectButton.translatesAutoresizingMaskIntoConstraints = false
        raceSelectButton.backgroundColor = UIColor.white
        raceSelectButton.setTitleColor(UIColor.mediumTextColor, for: .normal)
        raceSelectButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        raceSelectButton.setTitle("Select", for: .normal)
        addSubview(raceSelectButton)
        
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

            raceLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: spacing * 4),
            raceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            finishLabel.topAnchor.constraint(equalTo: raceLabel.bottomAnchor, constant: spacing * 3),
            finishLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            
            raceSelectButton.topAnchor.constraint(equalTo: raceLabel.topAnchor),
            raceSelectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),

            bottomBorder.topAnchor.constraint(equalTo: finishLabel.bottomAnchor, constant: spacing * 3),
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
