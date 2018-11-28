//
//  Schedule.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/28/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Schedule: NSObject {
    private var alarmTime: [Int] = []
    private var repeatAlarm: Bool = false
    private var daysActive: [Int] = []
    private var alarmEnabled: Bool = true
    private var activeAlarms: [Int : Date] = [ : ]
    
    
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
    
    func addDayToAlarm(daysArray: [Int]) {
        self.daysActive = daysArray
    }
    
    func getAlarmDays() -> [Int] {
        return self.daysActive
    }
    
    func setAlarmTime(hour : Int, minute: Int) {
        self.alarmTime.append(hour)
        self.alarmTime.append(minute)
    }
    
    func getAlarms() -> [Int : Date] {
        return activeAlarms
    }
    
    func setActiveAlarams() {
        //adds all of the different scheduled alarms to the activeAlarms array
        for day in daysActive {
            addDateToActiveAlarms(day)
        }
    }
    
    func addDateToActiveAlarms(_ day : Int) {
        var dateComponents = DateComponents()
        let calendar = Calendar(identifier: .gregorian)
        
        dateComponents.calendar = calendar
        
        //set time for the new alarm
        if alarmTime.count == 1 {
            dateComponents = setHoursAndMinutesForNewAlarm(dateComponents)
        } else {
            print("Time is out of range")
        }
        
        //set date for the new alarm
        let date = getNextDate(dayOfTheWeek: day)
        let nextScheduleDateComponents = calendar.dateComponents(in: .current, from: date)
        dateComponents.day = nextScheduleDateComponents.day
        dateComponents.month = nextScheduleDateComponents.month
        dateComponents.year = nextScheduleDateComponents.year
        
        activeAlarms[day] = dateComponents.date
    }
    
    private func setHoursAndMinutesForNewAlarm(_ dateComponents: DateComponents) -> DateComponents{
        var newDateComponents = dateComponents
        newDateComponents.hour = alarmTime[0]
        newDateComponents.minute = alarmTime[1]
        
        return newDateComponents
    }
    
    
    private func getNextDate(dayOfTheWeek: Int) -> Date{
        var newDate = Date()
        
        let calendar = Calendar(identifier: .gregorian)
        let todaysDateCompenents = calendar.dateComponents(in: .current, from: newDate)
        
        if let todaysDayOfTheWeek = todaysDateCompenents.weekday {
            print(dayOfTheWeek)
            if dayOfTheWeek == todaysDayOfTheWeek {
                //newDate is already set to today's date, make no changes
            } else if dayOfTheWeek < todaysDayOfTheWeek {
                // calculate the number of days to the next day of the week and return date
                let daysTillSetDate = dayOfTheWeek - todaysDayOfTheWeek + 7
                
                print(daysTillSetDate)
                if let modifiedDate = calendar.date(byAdding: .day, value: daysTillSetDate, to: newDate) {
                    newDate = modifiedDate
                }
            } else {
                //day is greater then todays day
                //calculate the number of days to the next day and return that day of the week
                let daysTillSetDate = dayOfTheWeek - todaysDayOfTheWeek
                if let modifiedDate = calendar.date(byAdding: .day, value: daysTillSetDate, to: newDate) {
                    newDate = modifiedDate
                }
            }
        } else {
            print("could not get today's day of the week")
        }
        
        return newDate
    }
    
    
}



