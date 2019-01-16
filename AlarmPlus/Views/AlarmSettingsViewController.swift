//
//  AlarmSettingsTableViewController.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class AlarmSettingsViewController: UIViewController {
    var alarm : Alarm?
    var alarmCurrentDays : [Int] = []
    var daySelectButtonsArray : [UIButton] = []
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    
    @IBAction func dateWasPressed(_ sender: Any) {
        guard let buttonPressed = sender as? UIButton else {
            return
        }
        if buttonPressed.isSelected {
            //The day that was selected is currently active in the alarm
            
            buttonPressed.isSelected = false
            if alarmCurrentDays.contains(buttonPressed.tag) {
                let fAlarmCurrentDays = alarmCurrentDays.filter {$0 != buttonPressed.tag}
                alarmCurrentDays = fAlarmCurrentDays
            }
        } else {
            //The day is pressed and currently is not active
            
            buttonPressed.isSelected = true
            if alarmCurrentDays.contains(buttonPressed.tag) == false {
                alarmCurrentDays.append(buttonPressed.tag)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if alarm == nil {
            setupNewAlarmInfo()
        } else {
            setupAlarmInfo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func setupView() {
        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(rightButtonAction(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        daySelectButtonsArray = [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        //Save UIBarbutton item actions
        guard let currentAlarm = alarm else {
            return
        }
        
        let (setHour, setMinute) = getUserSetTime(datePicker: datePicker)
        currentAlarm.schedule.setAlarmTime(hour: setHour, minute: setMinute)

        
        currentAlarm.schedule.setDayaActive(daysArray: alarmCurrentDays)

        
        currentAlarm.schedule.setActiveAlarms()
        
        print(currentAlarm.schedule.getAlarms())
    }
    
    //Function gets the information from existing alarm and pupulates it on the view
    func setupAlarmInfo() {
        
    }
    
    //Function creates a new alarm object and sets it with some default data
    func setupNewAlarmInfo() {
        alarm = Alarm()
        
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        var dateCompenents = calendar.dateComponents(in: .current, from: date)
        
        dateCompenents.hour = 12
        dateCompenents.minute = 0
        
        if let todaysDayOfTheWeekIndex = dateCompenents.weekday {
            alarmCurrentDays.append(todaysDayOfTheWeekIndex)
            
            for dayButton in daySelectButtonsArray {
                if dayButton.tag == todaysDayOfTheWeekIndex {
                    dayButton.isSelected = true
                }
            }
        }
        print(alarmCurrentDays)
        datePicker.date = calendar.date(from: dateCompenents)!
    }
    
    
    func getUserSetTime(datePicker: UIDatePicker) -> (Int, Int){
        var hour = 0
        var minute = 0
        let date = datePicker.date
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = calendar.dateComponents(in: .current, from: date)
        
        if let selectedHour = dateComponents.hour, let selectedMinute = dateComponents.minute {
            hour = selectedHour
            minute = selectedMinute
        }
        
        return (hour, minute)
    }
    
    func getUserSetDays() {
        
    }
    
    func createDateComponentsWithCalendar() -> DateComponents {
        var dateComponents = DateComponents()
        
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.calendar = calendar
        
        return dateComponents
    }
    
    func setCurrentAlarmDays() {
//        guard let seclectedAlarm = alarm else {
//            return
//        }
//
//        alarmCurrentDays = seclectedAlarm.schedule.getAlarmDays()
//
    }
}


extension AlarmSettingsViewController: StoryboardLoadable {
    static var storyboardName: String {
        return "AlarmSettings"
    }
}


extension AlarmSettingsViewController {
    enum constants {
        static let settingsArray = ["Time", "Days", "Repeat", "Snooze", "Alert", "Challenge"]
    }
}
