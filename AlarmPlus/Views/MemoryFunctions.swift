//
//  saveFunctions.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

enum MemoryFunctions {
    static func saveAlarmsDataToMemory(alarm: Alarm) {
        let userDefaults = UserDefaults()
        guard let currentSavedAlarmsArray = userDefaults.array(forKey: defaults.savedAlarms) as? [Alarm] else {
            return
        }
        
        var alarmsArray = currentSavedAlarmsArray
        alarmsArray.append(alarm)
        
        userDefaults.set(alarmsArray, forKey: defaults.savedAlarms)
    }
    
    static func getSavedAlarmsArray() -> [Alarm] {
        var alarmsArray : [Alarm] = []
        
        guard let arrayData = UserDefaults.standard.data(forKey: defaults.savedAlarms) else {
            return alarmsArray
        }
        
        do {
            let tempArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(arrayData) as? [Alarm]
            
            if let unarchrivedArray = tempArray {
                alarmsArray = unarchrivedArray
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return alarmsArray
    }
}

enum defaults {
    static let savedAlarms = "savedAlarms"
}
