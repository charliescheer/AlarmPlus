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
    //Set activeAlarms back to private after testing
    var activeAlarms: [Int : Date] = [ : ]
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
    
    func getAlarmDays() -> [Int] {
        return self.daysActiveArray
    }
    
    func getAlarmTimes() -> [Int] {
        let alarmTimesArray = getAlarmTimeArrayFromDateComponents()
        
        return alarmTimesArray
    }
    
    private func getAlarmTimeArrayFromDateComponents() -> [Int] {
        var alarmTimeArray: [Int] = []
        
        guard let hour = dateComponents.hour, let minute = dateComponents.minute else {
            return alarmTimeArray
        }
        
        alarmTimeArray = [hour, minute]
        
        return alarmTimeArray
    }
    
    func setAlarmTime(hour : Int, minute: Int) {
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
            addDateToActiveAlarmsDictionary(day)
        }
    }

    
    func getNextAlarmDate() -> Date {
        var nextAlarmDate = Date()
        
        let todaysDate = Date()

        
        var tempActiveAlarmsArray: [Date] = []
        for day in self.activeAlarms.values {
            tempActiveAlarmsArray.append(day)
        }
        
        tempActiveAlarmsArray.sort(by: <)
        
        if self.containsExpiredAlarms() {
            for day in tempActiveAlarmsArray {
                if day > todaysDate {
                    nextAlarmDate = day
                    break
                }
            }
        } else {
            //There is a crash here.  If there are no days set the tempActivealarms is empty.
            nextAlarmDate = tempActiveAlarmsArray[0]
        }
        
        return nextAlarmDate
    }
    
    func updateExpiredAlarms() {
        let todaysDate = Date()
        var expiredAlarms: [Int] = []
        
        if self.containsExpiredAlarms() {
            for date in activeAlarms.values {
                if date < todaysDate {
                    let calendar = Calendar(identifier: .gregorian)
                    let dayOfTheWeek = calendar.component(.weekday, from: date)
                    
                    expiredAlarms.append(dayOfTheWeek)
                }
            }
        }
        
        for day in expiredAlarms {
            let timeInterval = TimeInterval(exactly: 604800)
            if let tempDate = activeAlarms[day] {
              activeAlarms[day] = tempDate.addingTimeInterval(timeInterval!)
            }
            
        }
    }
    
    func containsExpiredAlarms() -> Bool {
        var includesExpiredAlarms = false
        
        let todaysDate = Date()
        
        for date in activeAlarms.values {
            if date < todaysDate {
                includesExpiredAlarms = true
            }
        }
        
        return includesExpiredAlarms
    }
    
    private func setAlarmDate(with date : Date) {
        alarmDate = date
    }
    
    func getAlarmDate() -> Date {
        return alarmDate
    }
    
    func getAlarmTimeString() -> String {
        var timeString : String = ""
        
        let alarmTimesArray = getAlarmTimeArrayFromDateComponents()
        
        if alarmTimesArray.count != 0 {
            if alarmTimesArray[0] <= 12 {
                timeString.append(String(alarmTimesArray[0]))
            } else {
                timeString.append(String(alarmTimesArray[0]-12))
            }
            
            timeString.append(" : ")
            
            if alarmTimesArray[1] > 9 {
                timeString.append(String(alarmTimesArray[1]))
            } else {
                timeString.append("0" + String(alarmTimesArray[1]))
            }
            
            if alarmTimesArray[0] < 12 {
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
        let alarmTimesArray = getAlarmTimeArrayFromDateComponents()
        
        timeInt = alarmTimesArray[0] * 100
        timeInt = timeInt + alarmTimesArray[1]
        
        return timeInt
    }
    
    func addDateToActiveAlarmsDictionary(_ dayOfTheWeek : Int) {
        let alarmTimesArray = getAlarmTimeArrayFromDateComponents()
        
        //confirms there is an hour and minute in the date components
        guard alarmTimesArray.count == 2 else {
            return
        }
        
        
        var tempDateComponents = self.dateComponents
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone.current
        calendar.timeZone = timeZone
        
        //set date for the new alarm
        let tempDate = getNextDate(dayOfTheWeek: dayOfTheWeek)
//        print(tempDate)
        let nextScheduleDateComponents = calendar.dateComponents(in: .current, from: tempDate)
//        print(nextScheduleDateComponents)
        tempDateComponents.day = nextScheduleDateComponents.day
        tempDateComponents.month = nextScheduleDateComponents.month
        tempDateComponents.year = nextScheduleDateComponents.year
        
//        print(tempDateComponents.date)
        activeAlarms[dayOfTheWeek] = tempDateComponents.date
   
        //I think this can be removed - doesn't do what was planned.
//        if let dateComponentsDate = dateComponents.date {
//            setAlarmDate(with: dateComponentsDate)
//        }

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
                
//                print(daysTillSetDate)
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



