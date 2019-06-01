//
//  Components.swift
//  RacePace
//
//  Created by Austin Louden on 5/31/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Label {
    static func titleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        label.textColor = UIColor.textColor
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func detailLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: standardFontSize)
        label.textColor = UIColor.mediumTextColor
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

class Button {
    static func button(with title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.lightTextColor
        button.setTitleColor(UIColor.textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: standardFontSize)
        button.setTitle(title, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing * 2, bottom: 0, right: spacing * 2)
        button.clipsToBounds = true
        button.layer.cornerRadius = cornerRadius;
        return button
    }
}

