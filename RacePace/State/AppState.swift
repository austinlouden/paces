//
//  AppState.swift
//  RacePace
//
//  Created by Austin Louden on 10/30/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import ReSwift

let store = Store(reducer: appReducer, state: nil)

struct AppState: StateType {
    var raceState: RaceState
}

struct RaceState: StateType {
    var pace: Int = 8
    var race: Race = Race.marathon
    var customRace: CustomRace?
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(raceState: raceReducer(action: action, state: state?.raceState))
}

// TODO: Move into reducers later

struct IncrementPace: Action {}
struct DecrementPace: Action {}
struct SelectRace: Action { let race: Race }

func raceReducer(action: Action, state: RaceState?) -> RaceState {
    var state = state ?? RaceState()
    
    switch action {
    case _ as IncrementPace:
        state.pace += 1
    case _ as DecrementPace:
        state.pace -= 1
    case let action as SelectRace:
        state.race = action.race
    default:
        break
    }
    
    return state
}
