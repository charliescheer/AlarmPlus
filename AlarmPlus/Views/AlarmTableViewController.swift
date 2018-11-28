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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedAlarmsFromMemory()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        saveSavedAlarmsToMemory()
    }
    
    func setupView() {
        view.backgroundColor = styles.backgroundColor
    }
    
    func getSavedAlarmsFromMemory() {
        let userDefaults = UserDefaults()
        if let savedAlarms = userDefaults.array(forKey: defaults.saved) as? [Date] {
            scheduledAlarmEvents = savedAlarms
        }
    }
    
    func saveSavedAlarmsToMemory() {
        let userDefaults = UserDefaults()
        userDefaults.array(forKey: defaults.saved)
    }
    
}

extension AlarmTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: constants.alarmCellIdentifier)
        cell.textLabel?.text = "test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledAlarmEvents.count
    }
    
    
}

extension AlarmTableViewController {
    enum defaults {
        static let saved = "savedAlarms"
    }
    
    enum constants {
        static let alarmCellIdentifier = "alarmCell"
    }
}

