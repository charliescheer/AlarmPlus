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
        tableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = definedColors.backgroundColor
        table.rowHeight = 95
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        MemoryFunctions.saveAlarmsToUserDefaults(alarmsArray)
    }
    
    
}

extension AlarmTableViewController {
    //TableView functions
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.alarmCellIdentifier, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell()
        }
        
        
        setupCellStyle(cell: cell)
        cell.scheduledTimeLabel.text = alarmsArray[indexPath.row].schedule.getAlarmTimeString()
        displayCellData(cell: cell, indexPath: indexPath)
        
        
        return cell
        
    }
    
    func displayCellData(cell: AlarmTableViewCell, indexPath: IndexPath) {
        let labelArray = [cell.sundayLabel, cell.mondayLabel, cell.tuesdayLabel, cell.wednesdayLabel, cell.thursdayLabel, cell.fridayLabel, cell.saturdayLabel]
        
        cell.scheduledTimeLabel.text = alarmsArray[indexPath.row].schedule.getAlarmTimeString()
        
        for day in alarmsArray[indexPath.row].schedule.getAlarmDays() {
            for label in labelArray {
                if day == label!.tag {
                    print(day, label?.tag)
                    label?.isHighlighted = true
                    print(label?.isHighlighted)
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
        
        controller.alarm = alarmsArray[indexPath.row]
        
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

