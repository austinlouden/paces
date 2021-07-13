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
  @State private var distance = Race.fiveK

  var body: some View {
    NavigationView {
      Form {
        Section {
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
          }
          Toggle("Use metric distances (e.g. km)", isOn: $showingAdvancedOptions.animation())

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
