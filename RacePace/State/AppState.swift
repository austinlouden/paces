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
        Storage.storeRaceState(state)
    case _ as DecrementPace:
        state.pace -= 1
        Storage.storeRaceState(state)
    case let action as SelectRace:
        state.race = action.race
        Storage.storeRaceState(state)
    case let action as SelectCustomRace:
        state.customRace = action.customRace
        state.race = .custom
        Storage.storeRaceState(state)
    case let action as LoadRaceState:
        state = action.state
    default:
        break
    }

    return state
}

// NAVIGATION STATE

struct NavigationState: StateType {
    // if -1, the table is its default state. Otherwise, this represents the row to expand on.
    var expansion: Int = -1
    var selectingDistance: Bool = false
    
    func expanded() -> Bool {
        return self.expansion != -1
    }
}

struct ExpandPaces: Action { let expansion: Int }
struct CollapsePaces: Action {}
struct ToggleDistanceSelector: Action {}

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()

    switch action {
        case let action as ExpandPaces:
            state.expansion = action.expansion
        case _ as CollapsePaces:
            state.expansion = -1
        case _ as ToggleDistanceSelector:
            state.selectingDistance = !state.selectingDistance
        default:
            break
    }

    return state
}
