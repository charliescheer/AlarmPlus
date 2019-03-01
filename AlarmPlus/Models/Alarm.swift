//
//  Alarm.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Alarm: Codable {


    var snooze = Snooze()
    var alert = Alert()
    var schedule = Schedule()
    
    init(snooze: Snooze, alert: Alert, schedule: Schedule) {
        self.snooze = snooze
        self.alert = alert
        self.schedule = schedule
    }
    
    func getSnooze() -> Snooze  {
        return snooze
    }
    
    func getAlert() -> Alert {
        return alert
    }

    func getSchedule() -> Schedule {
        return schedule
    }

}


extension Alarm {
    enum constants {
        static let daysOfTheWeek = [1 : "Sunday", 2 : "Monday", 3 : "Tuesday", 4 : "Wednesday", 5 : "Thursday", 6 : "Friday", 7 : "Saturday"]
    }
}
