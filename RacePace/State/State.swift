//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

// TODO: redux-ify all of this
fileprivate(set) public var appState = State()

public struct State {
    var pace = 7
    var race = Race.marathon
    var expanded = false
}

enum Action {
    case incrementPace
    case decrementPace
    case toggleExpansion
}

func reduce(action: Action, state: State?) -> State {
    
    var state = state ?? State()
    
    switch action {
    case .incrementPace:
        state.pace += 1
    case .decrementPace:
        state.pace -= 1
    case .toggleExpansion:
        if (state.expanded) {
            state.expanded = false
        } else {
            state.expanded = true
        }
    }
    
    appState = state
    return appState
}

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
