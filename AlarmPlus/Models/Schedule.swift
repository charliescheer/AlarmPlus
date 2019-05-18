//
//  Schedule.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/28/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Schedule: Codable {
//    private var alarmTime: [Int] = []
    private var daysActiveArray: [Int] = []
    private var dateComponents = DateComponents(withCalendar: .init(identifier: .gregorian))
    private var alarmDate = Date()
    private var activeAlarms: [Int : Date] = [ : ]
    private var nextAlarm = Date()
    private var repeatAlarm: Bool = false
    private var alarmEnabled: Bool = true
    
    init() {
        self.dateComponents.calendar?.timeZone = .current
    }
    
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
    
    func setDaysActive(daysArray: [Int]) {
        self.daysActiveArray = daysArray
    }
    
//    func addToDaysActive(dayIndex: Int) {
//        self.daysActive.append(dayIndex)
//    }
    
    func getAlarmDays() -> [Int] {
        return self.daysActiveArray
    }
    
    func getAlarmTimes() -> [Int] {
        return self.alarmTime
    }
    
    func setAlarmTime(hour : Int, minute: Int) {
        self.alarmTime = [hour, minute]
        self.dateComponents.hour = hour
        self.dateComponents.minute = minute
    }
    
    func getAlarms() -> [Int : Date] {
        return activeAlarms
    }
    
    func setActiveAlarmsArray() {
        //adds all of the different scheduled alarms to the activeAlarms array
        self.activeAlarms = [ : ]
        for day in daysActiveArray {
            addDateToActiveAlarms(day)
        }
    }
    
    private func setAlarmDate(with date : Date) {
        alarmDate = date
    }
    
    func getAlarmDate() -> Date {
        return alarmDate
    }
    
    func getAlarmTimeString() -> String {
        var timeString : String = ""
        
        if self.alarmTime.count != 0 {
            if self.alarmTime[0] <= 12 {
                timeString.append(String(self.alarmTime[0]))
            } else {
                timeString.append(String(self.alarmTime[0]-12))
            }
            
            timeString.append(" : ")
            
            if self.alarmTime[1] > 9 {
                timeString.append(String(self.alarmTime[1]))
            } else {
                timeString.append("0" + String(self.alarmTime[1]))
            }
            
            if self.alarmTime[0] < 12 {
                timeString.append(" am")
            } else {
                timeString.append(" pm")
            }
        }
        
        return timeString
    }
    
    func getTimeAsInt() -> Int {
        //This function is for ordering purposes.  There may be a better way to do this....
        
        var timeInt = 0
        
        timeInt = self.alarmTime[0] * 100
        timeInt = timeInt + self.alarmTime[1]
        
        return timeInt
    }
    
    func addDateToActiveAlarms(_ day : Int) {
        var dateComponents = DateComponents()
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone.current
        calendar.timeZone = timeZone
        
        dateComponents.calendar = calendar
        
        
        
        //set time for the new alarm
        if alarmTime.count == 2 {
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
        
        if let dateComponentsDate = dateComponents.date {
            setAlarmDate(with: dateComponentsDate)
        }

    }
    
    //returns an int that represents what day of the week it is currently.
    //Sunday = 1 and increases by one till Saturday = 7
    //If a date can't be obtained will return 1 - Sunday
    func getTodaysDayIndex() -> Int {
        var todaysDayIndex = 0
        
        let calendar = Calendar(identifier: .gregorian)
        let todaysDateCompenents = calendar.dateComponents(in: .current, from: Date())
        
        if let dayIndex = todaysDateCompenents.day {
            todaysDayIndex = dayIndex
        } else {
            todaysDayIndex = 1
        }
        
        return todaysDayIndex
    }
    
    private func setHoursAndMinutesForNewAlarm(_ dateComponents: DateComponents) -> DateComponents {
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
            if dayOfTheWeek == todaysDayOfTheWeek {
                //newDate is already set to today's date, make no changes
                // if currentTime =< alarmTime {
                //  make no changes
                //  else
                //  set time for the next day
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
    
    private func setNextAlarmDate() {
        let todaysIndex = getTodaysDayIndex()
        
        for day in daysActiveArray {
            if day == todaysIndex {
                
            }
        }
        
        
    }
    
    func setAlarmTimeZone(timezone: TimeZone) {
        self.dateComponents.calendar?.timeZone = timezone
    }
    
    
}



