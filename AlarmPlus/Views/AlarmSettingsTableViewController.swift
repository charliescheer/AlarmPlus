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
    
    @IBAction func doneWasPressed(_ sender: Any) {
        //create the dictionary in the Alarm object with all of the days and date objects
        
        //return to the alarm VC
        
    }
    
    @IBAction func testDoneWasPressed(_ sender: Any) {
        let controller = TimeSettingsUIViewController.loadViewController()
        navigationController?.pushViewController(controller, animated: true)
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AlarmSettingsTableViewController {
    enum constants {
        static let settingsArray = ["Time", "Days", "Repeat", "Snooze", "Alert", "Challenge"]
    }
}
