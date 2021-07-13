//
//  PaceFooter.swift
//  RacePace
//
//  Created by Austin Louden on 6/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

protocol PaceFooterDelegate: AnyObject {
  func paceFooterDidIncrementPace()
  func paceFooterDidDecrementPace()
}

class PaceFooter: UIView {

  weak var delegate: PaceFooterDelegate?

  let increaseButton = Button.button(with: "+1m")
  let decreaseButton = Button.button(with: "-1m")

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false

    increaseButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
    decreaseButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
    addSubview(increaseButton)
    addSubview(decreaseButton)

    NSLayoutConstraint.activate([
      decreaseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: kSpacing),
      decreaseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: kAppMargin),
      decreaseButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -kSpacing),
      decreaseButton.heightAnchor.constraint(equalToConstant: 40),
      decreaseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

      increaseButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: kSpacing),
      increaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -kAppMargin),
      increaseButton.heightAnchor.constraint(equalToConstant: 40),
      increaseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
    ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func increment() {
    self.delegate?.paceFooterDidIncrementPace()
  }

  @objc func decrement() {
    self.delegate?.paceFooterDidDecrementPace()
  }
}
