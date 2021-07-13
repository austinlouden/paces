//
//  AppState.swift
//  RacePace
//
//  Created by Austin Louden on 10/30/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import ReSwift
import UIKit

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
    UIImpactFeedbackGenerator().impactOccurred()
    Storage.storeRaceState(state)
  case _ as DecrementPace:
    state.pace -= 1
    UIImpactFeedbackGenerator().impactOccurred()
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

struct ToggleDistanceSelector: Action {}

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
  var state = state ?? NavigationState()

  switch action {
  case _ as ToggleDistanceSelector:
    UIImpactFeedbackGenerator().impactOccurred()
    state.selectingDistance = !state.selectingDistance
  default:
    break
  }

  return state
}
