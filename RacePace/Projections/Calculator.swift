//
//  Calculator.swift
//  RacePace
//
//  Created by Austin Louden on 6/5/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation

class PaceCalculator {
    
    static func calculatePaces(with event: Event) -> [Pace] {

        let VO2Max = PaceCalculator.getVO2Max(event)

        return [("Easy", 0.7),
                ("Tempo", 0.88),
                ("Max", 1.0),
                ("Speed", 1.1),
                ("Long", 0.6)].map { createPace(VO2ToVel(VO2Max * $0.1), $0.0) }
    }
    
    private static func getVO2Max(_ e: Event) -> Double {
        let m = e.time.timeInMinutes()
        let v = e.race.distance * 1609.34 / e.time.timeInMinutes()

        let vO2 = -4.60 + 0.182258 * v + 0.000104 * v * v
        let percentMax = 0.8 + 0.1894393 * exp(-0.012778 * m) + 0.2989558 * exp(-0.1932695 * m)
        let vO2Max = vO2 / percentMax

        return vO2Max
    }
    
    private static func VO2ToVel(_ VO2: Double) -> Double {
        return 29.54 + 5.000663 * VO2 - 0.007546 * VO2 * VO2
    }
    
    private static func createPace(_ speed: Double, _ name: String) -> Pace {
        let ans = 1 / speed * 1609
        let minutes = floor(ans)
        let seconds = floor((ans - minutes) * 60)
        return Pace(minutes: Int(minutes), seconds: Int(seconds), name: name)
    }
}
