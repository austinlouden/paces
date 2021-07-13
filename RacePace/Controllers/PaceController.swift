//
//  PaceController.swift
//  RacePace
//
//  Created by Austin Louden on 8/25/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import Foundation

class PaceController {

  enum TableState {
    case expanded
    case collapsed
  }

  static let distanceData = Race.allCases.map({ $0.longString }).dropLast()

  private(set) public var tableState: TableState = .collapsed
  private(set) public var raceState = RaceState()

  init() {
    if let savedState = Storage.loadRaceState() {
      raceState = savedState
    }
  }

  func toggleExpansion() {
    if tableState == .collapsed {
      tableState = .expanded
    } else {
      tableState = .collapsed
    }
  }

  func generateResults() -> [RaceResult] {
    if tableState == .expanded {
      let distance =
        raceState.race == .custom ? raceState.customRace?.distance() : raceState.race.distance
      let start = 1  // TODO: fix expansion on values
      let end = start + 5

      return [Int](start...end).map({ (i) -> RaceResult in

        let p = i == 60 ? raceState.pace + 1 : raceState.pace
        let s = i == 60 ? 0 : i

        let pace = Pace(minutes: p, seconds: s, name: nil)
        let finish = finishTime(with: pace, distance: distance ?? 0.0)

        return RaceResult(pace: pace, finishTime: finish)
      })
    } else {
      // TODO: Fix this distance check
      let distance =
        raceState.race == .custom ? raceState.customRace?.distance() : raceState.race.distance

      return [Int](0..<12).map({ (i) -> RaceResult in
        let pace = Pace(minutes: raceState.pace, seconds: i * 5, name: nil)
        let finish = finishTime(with: pace, distance: distance ?? 0.0)

        return RaceResult(pace: pace, finishTime: finish)
      })
    }
  }

  func incrementPace() {
    if raceState.pace < 30 {
      raceState.pace += 1
    }
  }

  func decrementPace() {
    if raceState.pace > 1 {
      raceState.pace -= 1
    }
  }
}
