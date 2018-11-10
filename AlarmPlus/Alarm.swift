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
//* enableRepeat -> Void
//* disableRepeat -> Void
//* doesAlarmRepeat -> Bool
//* addDateToAlarm(date) -> Void
//* getAlertDates -> [String] (possibly [Date])
//* resetSnoozeCount -> Void
//* increaseSnoozecount -> Void
//* getSnoozeCount -> Int
//* SetAlertType(sender: alertType) -> void
//* setSnoozeChallengeType(sender: challengeType) -> Void
//* isAlarmEnabled -> Bool
//* enableAlarm ->Void
//* disableAlarm -> Void
