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
        performSegue(withIdentifier: constants.alarmSettingsSegue, sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedAlarmsFromMemory()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        saveSavedAlarmsToMemory()
    }
    
    func setupView() {
        view.backgroundColor = definedColors.backgroundColor
        table.rowHeight = 95
    }
    
    func getSavedAlarmsFromMemory() {
        let userDefaults = UserDefaults()
        if let savedAlarms = userDefaults.array(forKey: defaults.saved) as? [Date] {
            scheduledAlarmEvents = savedAlarms
        }
        
        //TO DO - Get the array of alarms
        //TO DO - Possibly change the get savedAlarms userdefaults to send and receive from the system?
    
    }
    
    func saveSavedAlarmsToMemory() {
        let userDefaults = UserDefaults()
        userDefaults.array(forKey: defaults.saved)
    }
    
    //TO DO - Save the array of alarms
    //TO DO - Possibly change the save savedAlarms userdefaults to send and receive from the system?
    
}

extension AlarmTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.alarmCellIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell()
        }
        
        setupCellStyle(cell: cell)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsArray.count
    }
    
    func setupCellStyle(cell: AlarmTableViewCell) {
        cell.backgroundColor = definedColors.backgroundColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == constants.alarmSettingsSegue {
            let settingsVC = segue.destination as? AlarmTableViewController
            
            guard let alarmCell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: alarmCell) else {
                return
            }
            
            //TO DO - Pass the selected alarm to the settings View controller
            
        }
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

