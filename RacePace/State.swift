//
//  State.swift
//  Process
//
//  Created by Austin Louden on 4/22/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

// TODO: Add custom length when users tap on this
enum Race: Double {
    case fiveK = 3.10686
    case tenK = 6.21371
    case halfMarathon = 13.1094
    case marathon = 26.2188
}

struct State {
    let pace = 7
    let race = Race.fiveK
}

func paces(with state: State) -> [String] {
    return [Int](0...12).map { "\(state.pace):\(String(format: "%02d", $0 * 5))" }
}

func finishTimes(with state: State) -> [String] {
    return [Int](0...12).map({ (i) -> String in
        let paceInSeconds = 60 * state.pace + i * 5
        let finishTimeInSeconds = Int(round(state.race.rawValue * Double(paceInSeconds)))
        
        let hours = finishTimeInSeconds / 3600;
        let minutes = (finishTimeInSeconds % 3600) / 60;
        let seconds = finishTimeInSeconds % 60;

        return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    })
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
