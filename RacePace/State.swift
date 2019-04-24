//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

public struct State {
    let pace = 7
    let race = Race.marathon
}

fileprivate(set) public var appState = State()

func headerText(with state: State) -> String {
    switch state.race {
    case .fiveK:
        return "5K"
    case .tenK:
        return "10K"
    case .halfMarathon:
        return "Half-Marathon"
    case .marathon:
        return "Marathon"
    }
}
