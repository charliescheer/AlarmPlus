//
//  saveFunctions.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

enum MemoryFunctions {
    
    static func getSavedAlarmsArray() -> [Alarm] {
        var alarmsArray : [Alarm] = []
        
        guard let arrayData = UserDefaults.standard.data(forKey: defaults.savedAlarms) else {
            return alarmsArray
        }
        
        do {
            let unarchivedArray = try unarchiveAlarmArrayData(arrayData)
            alarmsArray = unarchivedArray
        } catch {
            print(error.localizedDescription)
        }
        
        return alarmsArray
    }
    
    static func unarchiveAlarmArrayData(_ data : Data) throws -> [Alarm] {
        var alarmsArray : [Alarm] = []
        
        do {
            let tempArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Alarm]
            
            if let unarchrivedArray = tempArray {
                alarmsArray = unarchrivedArray
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return alarmsArray
    }
    
    static func convertAlarmArrayToDate(alarmArray : [Alarm]) throws -> Data{
        var data = Data()
        
        let tempData = try NSKeyedArchiver.archivedData(withRootObject: alarmArray, requiringSecureCoding: false)
        
        data = tempData
        
        return data
    }
    
    static func saveAlarmsDataToMemory(alarmData: Data) {
        UserDefaults.standard.set(alarmData, forKey: defaults.savedAlarms)
    }
    
}

enum defaults {
    static let savedAlarms = "savedAlarms"
}
