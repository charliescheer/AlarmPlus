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
        print(dataArray)
        let decodedAlarmsArray = decodeAlarmsFromDataArray(dataArray)
        print(decodedAlarmsArray)
        alarmsArray = decodedAlarmsArray
        
        return alarmsArray
    }
    
    static func unarchiveAlarmArrayData(_ data : Data) throws -> [Alarm] {
        var alarmsArray : [Alarm] = []
        
        do {
            guard let unarchivedData = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [Alarm.self], from: data) as? Data else {
                return alarmsArray
            }
            let decoder = PropertyListDecoder()
            
            let decodedArray = try decoder.decode(Alarm.self, from: unarchivedData) as? [Alarm]
            
            if let alarmsArray = decodedArray {
                return alarmsArray
            } else {
                return alarmsArray
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return alarmsArray
    }
    
    static func convertAlarmArrayToData(alarmArray : [Alarm]) throws -> Data{
        var data = Data()
        
        let tempData = try NSKeyedArchiver.archivedData(withRootObject: alarmArray, requiringSecureCoding: false)
        
        data = tempData
        
        return data
    }
    
    static func saveAlarmsDataToMemory(alarmData: Data) {
        UserDefaults.standard.set(alarmData, forKey: defaults.savedAlarms)
    }
    
    static func archiveWithKeyedArchiver(object: Any) -> Data {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        
        archiver.outputFormat = .binary
        
        archiver.encode(object, forKey: "class")
        
        archiver.finishEncoding()
        
        let data = archiver.encodedData
        
        
        return data
    }
    
    static func unarchiveWithKeyedArchiver(archivedData: Data) throws -> Any {
        var test = TestClass()
        let unarchiver = try NSKeyedUnarchiver(forReadingFrom: archivedData)
        
        guard let data = unarchiver.decodeObject(forKey: "class") as? TestClass else {
            return test
        }
        
        test = data
        
        return test
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
