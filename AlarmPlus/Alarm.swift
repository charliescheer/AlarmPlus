//
//  Alarm.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Alarms: NSObject {
    private var alarmTime: [Int] = []
    private var timesSnoozed: Int = 0
    private var repeatAlarm: Bool = false
    private var daysActive: [String] = []
    private var alarmEnabled: Bool = true
    private var nextAlarm: NSDate?
    
    var snooze: Snooze?
    var alert: Alert?
    
    
    
    func enableRepeat() {
        self.repeatAlarm = true
    }
    
    func disableRepeat() {
        self.repeatAlarm = false
    }
    
    func doesAlarmRepeat() -> Bool {
        return repeatAlarm
    }
    
    func enableAlarm() {
        self.alarmEnabled = true
    }
    
    func disableAlarm() {
        self.alarmEnabled = false
    }
    
    func isAlarmEnabled() -> Bool {
        return alarmEnabled
    }
    
    func resetSnoozeCount() {
        self.timesSnoozed = 0
    }
    
    func increaseSnoozeCount() {
        self.timesSnoozed += 1
    }
    
    func getSnoozeCount() -> Int {
        return self.timesSnoozed
    }
    
    func addDayToAlarm(_ date: String) {
        self.daysActive.append(date)
    }
    
    func getAlarmDates() -> [String] {
        return self.daysActive
    }
    
    func removeDayFromAlarm(_ date: String){
        for day in daysActive {
            if date == day {
                daysActive.removeAll{
                    $0 == day
                }
            }
        }
    }
    
    func setAlarmTime(_ hour : Int, _ minute: Int) {
        self.alarmTime.append(hour)
        self.alarmTime.append(minute)
    }
    
    func getNextAlarm() -> NSDate? {
        if let alarm = nextAlarm {
            return alarm
        }
        return nil
    }
    
    func setNextAlarm() {
        var dateComponents = DateComponents()
        if alarmTime.count == 1 {
            dateComponents.hour = alarmTime[0]
            dateComponents.minute = alarmTime[1]
        } else {
            print("Time is out of range")
        }
        
        
        
    }
    
}

//* Methods


//* SetAlertType(sender: alertType) -> void
//* setSnoozeChallengeType(sender: challengeType) -> Void
//* setNextAlarm


//* COMPLETE isAlarmEnabled -> Bool
//* COMPLETE enableAlarm ->Void
//* COMPLETE disableAlarm -> Void
//* COMPLETE enableRepeat -> Void
//* COMPLETE disableRepeat -> Void
//* COMPLETE doesAlarmRepeat -> Bool
//* COMPLETE resetSnoozeCount -> Void
//* COMPLETE increaseSnoozecount -> Void
//* COMPLETE getSnoozeCount -> Int
//* COMPLETE addDateToAlarm(date) -> Void
//* COMPLETE getAlertDates -> [String] (possibly [Date])
//* COMPLETE removeDayFromAlarm(date) -> void
//* COMPLETE SetAlarmTime -> Void
//* COMPLETE GetNextAlarm -> NSDate
//* COMPLETE getNextAlarm
