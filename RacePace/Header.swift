//
//  Header.swift
//  RacePace
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import UIKit

class Header: UIView {

    static let height: CGFloat = 80.0
    
    let paceLabel = UILabel()
    let raceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        paceLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width/2.0, height: frame.size.height)
        paceLabel.text = NSLocalizedString("Pace", comment: "The time per mile or km.")
        addSubview(paceLabel)
        
        raceLabel.frame = CGRect(x: frame.size.width/2.0, y: 0, width: frame.size.width/2.0, height: frame.size.height)
        raceLabel.text = "Race" // depends on state
        addSubview(raceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
