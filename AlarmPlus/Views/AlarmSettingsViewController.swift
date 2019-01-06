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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    let UserCalendar = Calendar(identifier: .gregorian)
    
    
    @IBAction func dateWasPressed(_ sender: Any) {
        guard let buttonPressed = sender as? UIButton else {
            return
        }
        
        if buttonPressed.isHighlighted {
            //The day that was selected is currently active in the alarm
            buttonPressed.isHighlighted = false
            
            if alarmCurrentDays.contains(buttonPressed.tag) {
                let fAlarmCurrentDays = alarmCurrentDays.filter {$0 != buttonPressed.tag}
                alarmCurrentDays = fAlarmCurrentDays
            }
        } else {
            //The day is pressed and currently is not active
            buttonPressed.isHighlighted = true
            
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
        

        getUserSetTime(datePicker: datePicker)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setCurrentAlarmDays()
    }
    
    @IBAction func doneWasPressed(_ sender: Any) {
        //create the dictionary in the Alarm object with all of the days and date objects
        
        //return to the alarm VC
        
    }
    
    @IBAction func testDoneWasPressed(_ sender: Any) {
     
    }
    
    func setupView() {
        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(rightButtonAction(sender:)))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        //Save UIBarbutton item actions
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
        
        print(calendar.date(from: dateCompenents))
        
        
        print(date)
        print(dateCompenents)
        
        datePicker.date = calendar.date(from: dateCompenents)!

    
    }
    
    func getUserSetTime(datePicker: UIDatePicker) -> (Int, Int){
        var hour = 0
        var minute = 0
        let datePicker = datePicker
        
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents.init(withCalendar: calendar)
        
        print(dateComponents.calendar)
        
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
        guard let seclectedAlarm = alarm else {
            return
        }
        
        alarmCurrentDays = seclectedAlarm.schedule.getAlarmDays()
        
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
