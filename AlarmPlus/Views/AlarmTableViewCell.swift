//
//  AlarmTableViewCell.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/28/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scheduledTimeLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var alarmEnabledSwitch: UISwitch!
    @IBOutlet weak var snoozeLimitLabel: UILabel!
    
    @IBAction func alarmEnabledSwitchTapped(_ sender: Any) {
        //   ???
    }
    
}
