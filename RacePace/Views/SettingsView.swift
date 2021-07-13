//
//  SettingsView.swift
//  RacePace
//
//  Created by Austin Louden on 7/12/21.
//  Copyright © 2021 Austin Louden. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  @State private var showingAdvancedOptions = false
  @State private var customDistance = ""
  @State private var distance = Race.custom

  @State private var unit = 0

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Distance")) {
          Picker("Distance", selection: $distance) {
            Text(Race.fiveK.longString).tag(Race.fiveK)
            Text(Race.tenK.longString).tag(Race.tenK)
            Text(Race.halfMarathon.longString).tag(Race.halfMarathon)
            Text(Race.marathon.longString).tag(Race.marathon)
            Text("Custom").tag(Race.custom)
          }
          if distance == .custom {
            TextField("Custom distance", text: $customDistance)
              .keyboardType(.decimalPad)
            Picker("Custom distance units", selection: $unit) {
              Text("Miles")
              Text("Kilometers")
              Text("Meters")
              Text("Laps (400m)")
            }
          }
        }
        Section(header: Text("Pace")) {
          Toggle("Use metric pace (km)", isOn: $showingAdvancedOptions.animation())
        }
      }.navigationTitle("Settings")
    }

  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
