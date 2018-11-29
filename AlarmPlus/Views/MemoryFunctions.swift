//
//  saveFunctions.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

enum MemoryFunctions {
    static func saveAlarmsArrayToMemory(alarm: Alarm) {
        let userDefaults = UserDefaults()
        guard let currentSavedAlarmsArray = userDefaults.array(forKey: defaults.savedAlarms) as? [Alarm] else {
            return
        }
        
        var alarmsArray = currentSavedAlarmsArray
        alarmsArray.append(alarm)
        
        userDefaults.set(alarmsArray, forKey: defaults.savedAlarms)
    }
}

enum defaults {
    static let savedAlarms = "savedAlarms"
}
