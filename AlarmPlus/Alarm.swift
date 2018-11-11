//
//  Alarm.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Alarms: NSObject {
    private var alarmTime: NSDate?
    private var timesSnoozed: Int = 0
    private var repeatAlarm: Bool = false
    private var daysActive: [String] = []
    private var alarmEnabled: Bool = true
    
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
        
    }
}



//* Properties
//* Alarm Time : NSDate? - Private
//* Snooze: Snooze? - Public
//* Alert: Alert? - Public
//* number of times snoozed: int = 0 - Private
//* Repeat: Bool? - Private
//* Dates: [selected days of the week] - Private
//* alarm enabled: Bool = false

//* Methods
//* SetAlarm -> Void
//* GetAlarm -> NSDate
//* removeDayFromAlarm(date) -> void
//* SetAlertType(sender: alertType) -> void
//* setSnoozeChallengeType(sender: challengeType) -> Void

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
//* COMPLETE getAlertDates -> [String] (possibly [Date])\
