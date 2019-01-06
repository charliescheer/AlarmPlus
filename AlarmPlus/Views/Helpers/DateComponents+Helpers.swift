//
//  DateComponents+Helpers.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 1/6/19.
//  Copyright © 2019 Praxsis. All rights reserved.
//

import UIKit

extension DateComponents {
    init (withCalendar: Calendar) {
        self.init()
        self.calendar = calendar
    }
}
