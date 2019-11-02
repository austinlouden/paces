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
    var navigationState: NavigationState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        raceState: raceReducer(action: action, state: state?.raceState),
        navigationState: navigationReducer(action: action, state: state?.navigationState)
    )
}

// RACE STATE

struct RaceState: StateType, Codable {
    var pace: Int = 8
    var race: Race = Race.marathon
    var customRace: CustomRace?
}

struct IncrementPace: Action {}
struct DecrementPace: Action {}
struct SelectRace: Action { let race: Race }
struct SelectCustomRace: Action { let customRace: CustomRace }
struct LoadRaceState: Action { let state: RaceState }

func raceReducer(action: Action, state: RaceState?) -> RaceState {
    var state = state ?? RaceState()
    
    switch action {
    case _ as IncrementPace:
        state.pace += 1
    case _ as DecrementPace:
        state.pace -= 1
    case let action as SelectRace:
        state.race = action.race
    case let action as SelectCustomRace:
        state.customRace = action.customRace
        state.race = .custom
    case let action as LoadRaceState:
        state = action.state
    default:
        break
    }

    Storage.storeRaceState(state)
    return state
}

// NAVIGATION STATE

struct NavigationState: StateType {
    var expanded: Bool = false
    var selectingDistance: Bool = false
}

struct ExpandPaces: Action {}
struct CollapsePaces: Action {}
struct ToggleDistanceSelector: Action {}

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()

    switch action {
        case _ as ExpandPaces:
            state.expanded = true
        case _ as CollapsePaces:
            state.expanded = false
        case _ as ToggleDistanceSelector:
            state.selectingDistance = !state.selectingDistance
        default:
            break
    }

    return state
}
