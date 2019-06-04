//
//  ProjectionsView.swift
//  RacePace
//
//  Created by Austin Louden on 6/4/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class ProjectionsView: UIView {
    
    let titleLabel = Label.titleLabel(with: NSLocalizedString("Your paces", comment: "Your paces"))
    let goalLabel = Label.detailLabel(with: NSLocalizedString("Goal", comment: "Goal"))
    let lastLabel = Label.detailLabel(with: NSLocalizedString("Last race", comment: "Last race"))
    
    let goalTimeLabel = Label.detailLabel(with: "")
    let lastTimeLabel = Label.detailLabel(with: "")

    let bottomBorder = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        goalTimeLabel.textColor = UIColor.textColor
        lastTimeLabel.textColor = UIColor.textColor
        
        addSubview(titleLabel)
        addSubview(goalLabel)
        addSubview(goalTimeLabel)
        addSubview(lastLabel)
        addSubview(lastTimeLabel)
        
        bottomBorder.backgroundColor = UIColor.lightTextColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: kSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -kSpacing),
            
            goalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kSpacing),
            goalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kSpacing),
            goalLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -kSpacing),
            
            goalTimeLabel.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: kSpacing),
            goalTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kSpacing),
            goalTimeLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -kSpacing),
            
            lastLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kSpacing),
            lastLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: kSpacing),
            lastLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -kSpacing),
            
            lastTimeLabel.topAnchor.constraint(equalTo: lastLabel.bottomAnchor, constant: kSpacing),
            lastTimeLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: kSpacing),
            lastTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -kSpacing),

            bottomBorder.topAnchor.constraint(equalTo: lastTimeLabel.bottomAnchor, constant: kSpacing * 3),
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
