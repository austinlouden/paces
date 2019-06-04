//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation
import UIKit

fileprivate(set) public var appState = State()

public struct State {
    // paces
    var pace = 8
    var race = Race.marathon
    var expanded = false
    var selectingDistance = false

    // projections
    var lastRace: Race?
    var lastTime: FinishTime?
    var goalRace: Race?
    var goalTime: FinishTime?
}

enum Action: Equatable {
    // paces
    case selectRace(race: Race)
    case incrementPace
    case decrementPace
    case toggleExpansion
    case toggleDistanceSelection
    
    // projections
    case presentProjectionsNUX
    case setGoalRace(race: Race, time: FinishTime)
    case setLastRace(race: Race, time: FinishTime)
}

func reduce(action: Action, state: State?) {
    var state = state ?? State()
    
    switch action {
    case .selectRace(let race):
        UIImpactFeedbackGenerator().impactOccurred()
        state.race = race
    case .incrementPace:
        UIImpactFeedbackGenerator().impactOccurred()
        state.pace = updatePace(pace: state.pace, increment: true)
    case .decrementPace:
        UIImpactFeedbackGenerator().impactOccurred()
        state.pace = updatePace(pace: state.pace, increment: false)
    case .toggleExpansion:
        UIImpactFeedbackGenerator().impactOccurred()
        state.expanded = !state.expanded
    case .toggleDistanceSelection:
        UIImpactFeedbackGenerator().impactOccurred()
        state.selectingDistance = !state.selectingDistance
        state.expanded = false
        
    // projections
    case .presentProjectionsNUX:
        break
    case .setGoalRace(let race, let time):
        state.goalRace = race
        state.goalTime = time
        storeRace(race, time, true)
    case .setLastRace(let race, let time):
        state.lastRace = race
        state.lastTime = time
        storeRace(race, time, false)
    
    }
    
    appState = state
    NotificationCenter.default.post(name: .stateDidChange, object: action)
}

private func updatePace(pace: Int, increment: Bool) -> Int {
    let newPace = increment ? pace + 1 : pace - 1
    
    if (newPace > -1 && newPace < 31) {
        return newPace
    }

    UINotificationFeedbackGenerator().notificationOccurred(.error)
    return pace
}

private func storeRace(_ race: Race, _ time: FinishTime, _ isGoal: Bool) {
    print(race, time, isGoal)
}

extension Notification.Name {
    static let stateDidChange = Notification.Name("stateDidChange")
}
