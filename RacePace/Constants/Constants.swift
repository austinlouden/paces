//
//  Colors.swift
//  RacePace
//
//  Created by Austin Louden on 5/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

let kAppMargin: CGFloat = 24.0
let kSpacing: CGFloat = 4.0
let kCornerRadius: CGFloat = 8.0

let extraLargeFontSize: CGFloat = 24.0
let titleFontSize: CGFloat = 18.0
let standardFontSize: CGFloat = 14.0

let kRaceStateDefaultsKey = "kRaceStateDefaultsKey"

extension UIColor {
  static let buttonColor = UIColor(white: 229.0 / 255.0, alpha: 1.0)
  static let textColor = UIColor.label
  static let mediumTextColor = UIColor.secondaryLabel
  static let lightTextColor = UIColor.tertiaryLabel

  static let bostonBlue = UIColor(
    displayP3Red: 26.0 / 255.0, green: 49.0 / 255.0, blue: 115 / 255.0, alpha: 1.0)
}
