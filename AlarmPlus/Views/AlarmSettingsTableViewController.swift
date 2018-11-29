//
//  AlarmSettingsTableViewController.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class AlarmSettingsTableViewController: UITableViewController {
    var alarm : Alarm?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if alarm == nil {
            setupNewAlarmInfo()
        } else {
            setupAlarmInfo()
        }
    }
    
    //Function gets the information from existing alarm and pupulates it on the view
    func setupAlarmInfo() {
        
    }
    
    //Function creates a new alarm object and sets it with some default data
    func setupNewAlarmInfo() {
        alarm = Alarm()
        
        alarm!.schedule.setAlarmTime(hour: 12, minute: 00)
        alarm!.schedule.addDayToAlarm(dayInt: alarm!.schedule.getTodaysDayIndex())
    }
}

extension AlarmSettingsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constants.settingsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell(style: .default, reuseIdentifier: "settingsCell")
        
        cell.textLabel?.text = constants.settingsArray[indexPath.row]
        
        return cell
    }
}

extension AlarmSettingsTableViewController {
    enum constants {
        static let settingsArray = ["Time", "Days", "Repeat", "Snooze", "Alert", "Challenge"]
    }
}
