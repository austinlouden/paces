//
//  Cell.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()
    let tagButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white

        paceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        paceLabel.textColor = UIColor.textColor
        paceLabel.translatesAutoresizingMaskIntoConstraints = false
        paceLabel.backgroundColor = UIColor.white

        raceLabel.font = UIFont.systemFont(ofSize: 18)
        raceLabel.textColor = UIColor.textColor
        raceLabel.translatesAutoresizingMaskIntoConstraints = false
        raceLabel.backgroundColor = UIColor.white
        
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tagButton.isHidden = true
        tagButton.setTitleColor(UIColor.white, for: .normal)
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        tagButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: kSpacing + 2, bottom: 0, right: kSpacing + 2)
        tagButton.backgroundColor = UIColor.bostonBlue
        tagButton.clipsToBounds = true
        tagButton.layer.cornerRadius = 8;

        contentView.addSubview(paceLabel)
        contentView.addSubview(raceLabel)
        contentView.addSubview(tagButton)
        
        NSLayoutConstraint.activate([
            paceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            raceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            paceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kAppMargin + 4),
            raceLabel.leadingAnchor.constraint(equalTo: paceLabel.trailingAnchor, constant: 8),
            
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kAppMargin),
            tagButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagButton.isHidden = true
    }
}

extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        
        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
        let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}
