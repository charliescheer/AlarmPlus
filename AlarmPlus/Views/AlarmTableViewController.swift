//
//  ViewController.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController {
    var scheduledAlarmEvents : [Date] = []
    var alarmsArray : [Alarm] = []
    
    @IBOutlet var table: UITableView!
    
    @IBAction func editWasPressed(_ sender: Any) {

    }
    
    @IBAction func addWasPressed(_ sender: Any) {
        let controller = AlarmSettingsViewController.loadViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        alarmsArray = MemoryFunctions.getSavedAlarmsArray()
        alarmsArray = sortAlarmsArrayByTimeOfDay()
        tableView.reloadData()
        
        for alarm in alarmsArray {
            if alarm.schedule.containsExpiredAlarms() {
                alarm.schedule.updateExpiredAlarms()
                
                print(alarm.schedule.getAlarms())
            }
        }

        //save for adding temporary data for testing.
//        createTempData()
//        MemoryFunctions.saveAlarmsToUserDefaults(alarmsArray)
//        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        MemoryFunctions.saveAlarmsToUserDefaults(alarmsArray)
    }
    
    //MARK: Setup Functions
    func setupView() {
        view.backgroundColor = definedColors.backgroundColor
        table.rowHeight = 95
    }
    
    func sortAlarmsArrayByTimeOfDay() -> [Alarm] {
        let sortedArray = alarmsArray.sorted {$0.schedule.getTimeAsInt() < $1.schedule.getTimeAsInt()}
        
        return sortedArray
    }
    
    func createTempData() {
        let tempAlarm = Alarm(snooze: Snooze(), alert: Alert(), schedule: Schedule())
        
        let daysActiveArray = [1,3,5,6]
        
        tempAlarm.schedule.setDaysActive(daysArray: daysActiveArray)
        tempAlarm.schedule.setAlarmTime(hour: 8, minute: 00)
        
        tempAlarm.schedule.setActiveAlarmsArray()
        
        print(tempAlarm.schedule.getAlarms())
        
        let alarmDates = tempAlarm.schedule.getAlarms()
        var tempDates: [Date] = []
        
        for day in daysActiveArray {
            tempDates.append(alarmDates[day]!)
        }
        
        var newDates: [Date] = []
        let timeInterval = TimeInterval(exactly: -259200)
        for date in tempDates {
            let newdate = date.addingTimeInterval(timeInterval!)
            newDates.append(newdate)
        }
        
        print(newDates)
        
        tempAlarm.schedule.activeAlarms.removeAll()
        
        for day in newDates {
            let calendar = Calendar.init(identifier: .gregorian)
            let dateComponents = calendar.dateComponents(in: .current, from: day)
            
            if let weekday = dateComponents.weekday {             tempAlarm.schedule.activeAlarms[weekday] = day
            }
        }
        
        print(tempAlarm.schedule.activeAlarms.keys)
        alarmsArray.append(tempAlarm)
    }
    
}

extension AlarmTableViewController {
    //TableView functions
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.alarmCellIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell()
        }
        
        
        setupCellStyle(cell: cell)
        displayCellData(cell: cell, indexPath: indexPath)
        
        
        return cell
        
    }
    
    func displayCellData(cell: AlarmTableViewCell, indexPath: IndexPath) {
        let labelArray = [cell.sundayLabel, cell.mondayLabel, cell.tuesdayLabel, cell.wednesdayLabel, cell.thursdayLabel, cell.fridayLabel, cell.saturdayLabel]
        
        cell.scheduledTimeLabel.text = alarmsArray[indexPath.row].schedule.getAlarmTimeString()
        
        for day in alarmsArray[indexPath.row].schedule.getAlarmDays() {
            for label in labelArray {
                if day == label!.tag {
                    label!.isHighlighted = true
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsArray.count
    }
    
    func setupCellStyle(cell: AlarmTableViewCell) {
        let labelArray = [cell.sundayLabel, cell.mondayLabel, cell.tuesdayLabel, cell.wednesdayLabel, cell.thursdayLabel, cell.fridayLabel, cell.saturdayLabel]
        cell.backgroundColor = definedColors.backgroundColor
        
        for label in labelArray {
            label?.textColor = definedColors.deactivatedFontColor
            label?.highlightedTextColor = definedColors.activatedFrontColor
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AlarmSettingsViewController.loadViewController()
        
        controller.alarmInView = alarmsArray[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.alarmsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
     
        return [delete]
    }
}

extension AlarmTableViewController {
    enum defaults {
        static let saved = "savedAlarms"
    }
    
    enum constants {
        static let alarmCellIdentifier = "alarmCell"
        static let alarmSettingsSegue = "toAlarmSettings"
    }
}

