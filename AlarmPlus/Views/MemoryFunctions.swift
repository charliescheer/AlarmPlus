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
        
        guard let savedData = UserDefaults.standard.data(forKey: defaults.savedAlarms) else {
            return alarmsArray
        }

       let dataArray = unarchiveDataArray(savedData)
        let decodedAlarmsArray = decodeAlarmsFromDataArray(dataArray)
        alarmsArray = decodedAlarmsArray
        
        return alarmsArray
    }
    
    static func saveAlarmsDataToMemory(alarmData: Data) {
        UserDefaults.standard.set(alarmData, forKey: defaults.savedAlarms)
    }
    
    static func archiveAlarmsToDataArray(_ alarmsArray : [Alarm]) -> [Data] {
        var dataArray : [Data] = []
        
        for alarm in alarmsArray {
            let encoder = PropertyListEncoder()
            do {
                let alarmData = try encoder.encode(alarm)
                dataArray.append(alarmData)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return dataArray
    }
    
    static func archiveDataArray(_ dataArray : [Data]) -> Data {
        var data = Data()
        
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: false)
            data = archivedData
        } catch {
            print(error.localizedDescription)
        }
        
        return data
    }
    
    static func unarchiveDataArray(_ data : Data) -> [Data] {
        var dataArray : [Data] = []
        
        do {
            let decodedArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Data]
            
            if let arrayData = decodedArray{
                dataArray = arrayData
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
        return dataArray
    }
    
    static func decodeAlarmsFromDataArray(_ dataArray : [Data]) -> [Alarm] {
        var alarmsArray : [Alarm] = []
        
        let decoder = PropertyListDecoder()
        
        for data in dataArray {
            do {
                let decodedAlarm = try decoder.decode(Alarm.self, from: data)
                alarmsArray.append(decodedAlarm)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return alarmsArray
    }
}

extension MemoryFunctions {
    enum defaults {
        static let savedAlarms = "savedAlarms"
    }
}
