//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

struct State {
    let pace = 7
}

func paces(with state: State) -> [String] {
    return [Int](0...12).map { "\(state.pace):\(String(format: "%02d", $0 * 5))" }
}
