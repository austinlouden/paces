//
//  Storage.swift
//  RacePace
//
//  Created by Austin Louden on 11/1/19.
//  Copyright © 2019 Austin Louden. All rights reserved.
//

import Foundation
import ReSwift

struct RaceState: Codable {
    var pace: Int = 8
    var race: Race = Race.marathon
    var customRace: CustomRace?
}

class Storage {
    public static func storeRaceState(_ raceState: RaceState) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(raceState), forKey:kRaceStateDefaultsKey)
    }

    public static func loadRaceState() -> RaceState? {
        guard let data = UserDefaults.standard.value(forKey:kRaceStateDefaultsKey) as? Data else { return nil }
        guard let raceState = try? PropertyListDecoder().decode(RaceState.self, from: data) else { return nil }
        return raceState
    }
}
