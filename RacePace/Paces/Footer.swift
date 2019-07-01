//
//  Footer.swift
//  RacePace
//
//  Created by Austin Louden on 6/14/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Footer: UIView {
    let increaseButton = Button.button(with: "+1m")
    let decreaseButton = Button.button(with: "-1m")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            increaseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func increment() {
        // TODO: make these buttons work in the expanded state
        if (!appState.expanded) {
            reduce(action: .incrementPace, state: appState)
        }
    }
    
    @objc func decrement() {
        if (!appState.expanded) {
            reduce(action: .decrementPace, state: appState)
        }
    }
}
