//
//  PaceController.swift
//  RacePace
//
//  Created by Austin Louden on 8/25/20.
//  Copyright © 2020 Austin Louden. All rights reserved.
//

import Foundation

class PaceController {
    
    static let distanceData = Race.allCases.map({ $0.longString }).dropLast()
    
    static func buildCellData(with state: AppState) -> [RaceResult] {
        if (state.navigationState.expanded()) {
            let distance = state.raceState.race == .custom ? state.raceState.customRace?.distance() : state.raceState.race.distance
            let start = state.navigationState.expansion * 5
            let end = start + 5

            return [Int](start...end).map({ (i) -> RaceResult in
                
                let p = i == 60 ? state.raceState.pace + 1 : state.raceState.pace
                let s = i == 60 ? 0 : i

                let pace = Pace(minutes: p, seconds: s, name: nil)
                let finish = finishTime(with: pace, distance: distance ?? 0.0)

                return RaceResult(pace: pace, finishTime: finish)
            })
        } else {
            // TODO: Fix this distance check
            let distance = state.raceState.race == .custom ? state.raceState.customRace?.distance() : state.raceState.race.distance

            return [Int](0..<12).map({ (i) -> RaceResult in
                let pace = Pace(minutes: state.raceState.pace, seconds: i * 5, name: nil)
                let finish = finishTime(with: pace, distance: distance ?? 0.0)

                return RaceResult(pace: pace, finishTime: finish)
            })
        }
    }
}
