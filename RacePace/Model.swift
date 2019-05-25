//
//  Model.swift
//  RacePace
//
//  Created by Austin Louden on 4/24/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

struct FinishTime {
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    func finishTimeString() -> String {
        return "\(String(format: "%02d", self.hours)):\(String(format: "%02d", self.minutes)):\(String(format: "%02d", self.seconds))"
    }
}

struct Pace {
    let minutes: Int
    let seconds: Int
    
    func paceString() -> String {
        return "\(self.minutes):\(String(format: "%02d", self.seconds))"
    }
}

public enum Race: Int, CaseIterable {
    case fiveK
    case tenK
    case halfMarathon
    case marathon

    var distance: Double {
        switch self {
        case .fiveK:
            return 3.10686
        case .tenK:
            return 6.21371
        case .halfMarathon:
            return 13.1094
        case .marathon:
            return 26.2188
        }
    }

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

    return FinishTime(hours: hours, minutes: minutes, seconds: seconds)
}

struct CellData: Equatable {
    let pace: Pace
    let finishTime: FinishTime
    let tags: [String]
    
    static func ==(lhs: CellData, rhs: CellData) -> Bool {
        return lhs.pace.minutes == rhs.pace.minutes && lhs.pace.seconds == rhs.pace.seconds
    }
}

func buildCellData(with state: State) -> [CellData] {
    return [Int](0..<12).map({ (i) -> CellData in
        let pace = Pace(minutes: state.pace, seconds: i * 5)
        let finish = finishTime(with: pace, distance: state.race.distance)
        let tags = landmarks[pace.paceString()] ?? []

        return CellData(pace: pace, finishTime: finish, tags: tags)
    })
}

func buildIntervalCellData(with data: [CellData], state: State) -> [CellData] {
    var newData = [CellData]()
    guard let first = data.first else { assertionFailure(); return data }
    
    let interval = data.count == 2 ? 5 : 4

    newData += [Int](first.pace.seconds ... first.pace.seconds + interval).map { i -> CellData in
        let pace = Pace(minutes: first.pace.minutes, seconds: i)
        let finish = finishTime(with: pace, distance: state.race.distance)
        let tags = landmarks[pace.paceString()] ?? []
        return CellData(pace: pace, finishTime: finish, tags: tags)
    }

    return newData
}

func buildDataForRaces() -> [String] {
    return Race.allCases.map({ $0.string })
}
