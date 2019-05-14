//
//  AlarmSettingsTableViewController.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/29/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class AlarmSettingsViewController: UIViewController {
    var alarmInView : Alarm?
    var selectedDays : [Int] = []
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
            if selectedDays.contains(buttonPressed.tag) {
                let fAlarmCurrentDays = selectedDays.filter {$0 != buttonPressed.tag}
                selectedDays = fAlarmCurrentDays
                print(selectedDays)
            }
        } else {
            //The day is pressed and currently is not active
            
            buttonPressed.isSelected = true
            if selectedDays.contains(buttonPressed.tag) == false {
                selectedDays.append(buttonPressed.tag)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if alarmInView == nil {
            //right now this just displays noon, it doesn't create a new alarm or anything else.
            setupNewAlarmInfo()
            print("new alarm")
        } else {
            setupAlarmInfo()
            print("old alarm")
        }
    }
    
    
    func setupView() {
        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(rightButtonAction(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        daySelectButtonsArray = [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        //Save UIBarbutton item actions
        var alarmsArray = MemoryFunctions.getSavedAlarmsArray()
        
        let (setHour, setMinute) = getUserSetTime(datePicker: datePicker)
        
        if let currentAlarm = alarmInView {
            //If there is an alarm already update exsisting alarm
        
            currentAlarm.schedule.setAlarmTime(hour: setHour, minute: setMinute)
            currentAlarm.schedule.setDaysActive(daysArray: selectedDays)
            currentAlarm.schedule.setActiveAlarms()
            
            let uuid = currentAlarm.uuid
            
            alarmsArray.removeAll { (currentAlarm) -> Bool in
                if case uuid = currentAlarm.uuid {
                    return true
                } else {
                    return false
                }
            }
            
            alarmsArray.append(currentAlarm)
            
            MemoryFunctions.saveAlarmsToUserDefaults(alarmsArray)
        } else {
            //if the alarm is nil create a new alarm with the current settings
            let newAlarm = Alarm(hour: setHour, minute: setMinute)
            
            newAlarm.schedule.setDaysActive(daysArray: selectedDays)
            newAlarm.schedule.setActiveAlarms()
            
            alarmsArray.append(newAlarm)
            
            MemoryFunctions.saveAlarmsToUserDefaults(alarmsArray)
        }
        
        self.navigationController?.popViewController(animated: true)

    }
    
    //Function gets the information from existing alarm and pupulates it on the view
    func setupAlarmInfo() {
        guard let currentAlarm = alarmInView else {
            return
        }
        
        datePicker.date = currentAlarm.schedule.getAlarmDate()
        
        let alarmDaysActive = currentAlarm.schedule.getAlarmDays()
        selectedDays = alarmDaysActive
        
        for day in alarmDaysActive {
            for dayButton in daySelectButtonsArray {
                if day == dayButton.tag {
                    dayButton.isSelected = true
                    
                }
            }
        }
    }
    
    //Function creates a new alarm object and sets it with some default data
    func setupNewAlarmInfo() {
//        alarm = Alarm(hour: 12, minute: 00)
//
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        var dateCompenents = calendar.dateComponents(in: .current, from: date)
        
        dateCompenents.hour = 12
        dateCompenents.minute = 0
        
//        if let todaysDayOfTheWeekIndex = dateCompenents.weekday {
//            selectedDays.append(todaysDayOfTheWeekIndex)
//
//            for dayButton in daySelectButtonsArray {
//                if dayButton.tag == todaysDayOfTheWeekIndex {
//                    dayButton.isSelected = true
//                }
//            }
//        }
        datePicker.date = calendar.date(from: dateCompenents)!
    }
    
    //NOTE: see if this can be added to UIDatePicker instead of in the view controller
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
    
    //NOTE: See if I can add this to DateComponents, maybe as a convenience init
    func createDateComponentsWithCalendar() -> DateComponents {
        var dateComponents = DateComponents()
        
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.calendar = calendar
        
        return dateComponents
    }
    
    func setCurrentAlarmDays() {

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
