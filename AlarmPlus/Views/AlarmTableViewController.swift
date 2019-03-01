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
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsArray.count
    }
    
    func setupCellStyle(cell: AlarmTableViewCell) {
        cell.backgroundColor = definedColors.backgroundColor
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.alarmsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
     
        return [delete]
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == constants.alarmSettingsSegue {
//            let settingsVC = segue.destination as? AlarmTableViewController
//
//            guard let alarmCell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: alarmCell) else {
//                return
//            }
    
            //TO DO - Pass the selected alarm to the settings View controller
            
//        }
//    }
    
    
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

