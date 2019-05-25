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
        
        detailLabel.text = NSLocalizedString("Enter in a time from a previous race to calculate training paces." +
            "You can also choose to enter your training paces in manually.", comment: "Welcome")
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor.mediumTextColor
        detailLabel.backgroundColor = UIColor.white
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            detailLabel.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -spacing)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
