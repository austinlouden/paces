//
//  Model.swift
//  RacePace
//
//  Created by Austin Louden on 4/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

typealias Pace = (minutes: Int, seconds: Int)
typealias FinishTime = (hours: Int, minutes: Int, seconds: Int)

public enum Race: Double, CaseIterable {
    case fiveK = 3.10686
    case tenK = 6.21371
    case halfMarathon = 13.1094
    case marathon = 26.2188

    var string: String {
        switch self {
        case .fiveK:
            return "5K"
        case .tenK:
            return "10K"
        case .halfMarathon:
            return "Half Marathon"
        case .marathon:
            return "Marathon"
        }
    }
}

func finishTime(with pace:Pace, distance: Double) -> FinishTime {
    let paceInSeconds = 60 * pace.minutes + pace.seconds
    let finishTimeInSeconds = Int(round(distance * Double(paceInSeconds)))
    
    let hours = finishTimeInSeconds / 3600
    let minutes = (finishTimeInSeconds % 3600) / 60
    let seconds = finishTimeInSeconds % 60

    return (hours, minutes, seconds)
}

struct CellData: Equatable {
    let pace: Pace
    let finishTime: FinishTime

    func paceString() -> String {
        return "\(pace.minutes):\(String(format: "%02d", pace.seconds))"
    }
    
    func finishTimeString() -> String {
        return "\(String(format: "%02d", finishTime.hours)):\(String(format: "%02d", finishTime.minutes)):\(String(format: "%02d", finishTime.seconds))"
    }
    
    static func ==(lhs: CellData, rhs: CellData) -> Bool {
        return lhs.pace.minutes == rhs.pace.minutes && lhs.pace.seconds == rhs.pace.seconds
    }
}

func buildCellData(with state: State) -> [CellData] {
    return [Int](0..<12).map({ (i) -> CellData in
        let pace = (state.pace, i * 5)
        let finish = finishTime(with: pace, distance: state.race.rawValue)

        return CellData(pace: pace, finishTime: finish)
    })
}

func buildIntervalCellData(with data: [CellData], state: State) -> [CellData] {
    assert(data.count == 2, "This method builds the interval between 2 data points.")
    
    var newData = [CellData]()
    
    guard let first = data.first, let last = data.last else { assertionFailure(); return data }

    newData += [Int](first.pace.seconds + 1 ..< last.pace.seconds).map { i -> CellData in
        let pace = (first.pace.minutes, i)
        let finish = finishTime(with: pace, distance: state.race.rawValue)
        return CellData(pace: pace, finishTime: finish)
    }

    newData.insert(first, at: 0)
    newData.append(last)
    return newData
}

func buildDataForRaces() -> [String] {
    return Race.allCases.map({ $0.string })
}
