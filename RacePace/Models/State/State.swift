//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation
import UIKit

public struct State {
    // paces
    var pace = 8
    var race = Race.marathon
    var customRace: CustomRace?
    var expanded = false
    var selectingDistance = false
}

enum AnAction: Equatable {
    // paces
    case selectRace(race: Race)
    case toggleDistanceSelection
}

func reduce(action: AnAction, state: State?) {
    var state = state ?? State()
    
    switch action {

    case .selectRace(let race):
        UIImpactFeedbackGenerator().impactOccurred()
        state.race = race
    case .toggleDistanceSelection:
        UIImpactFeedbackGenerator().impactOccurred()
        state.selectingDistance = !state.selectingDistance
        state.expanded = false
    }
    
    //appState = state
    NotificationCenter.default.post(name: .stateDidChange, object: action)
}

extension Notification.Name {
    static let stateDidChange = Notification.Name("stateDidChange")
}
