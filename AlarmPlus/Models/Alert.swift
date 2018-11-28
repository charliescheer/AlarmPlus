//
//  Alert.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Alert: NSObject {
    private var fadeInEnabled : Bool = false
    private var alertVolume : Double?
    
    func enableFadeIn() {
        fadeInEnabled = true
    }
    
    func disableFadeIn() {
        fadeInEnabled = false
    }
    
    func isFadeInEnabled() -> Bool {
        return fadeInEnabled
    }
    
    func triggerAlert() {
        
    }
    
    func getSystemAlertVolume() -> Double {
        var systemAlertVolume = 0.00
        
        //get the current set volume for alerts from iOS
        
        return systemAlertVolume
    }
    
    func setAlarmVolume() {
        
    }
    
    func getAlarmVolume() -> Double? {
        return alertVolume
    }
}

//* Properties
//* FadeIn: Bool - Private
//* Volume: Double - Private

//* Methods (Set methods to final, should not need to be changed in sub classes)
//* SilenceAlert -> void
//COMPLETE enabledFadeIn -> void
//COMPLETE disableFadeIn-> void
//COMPLETE isFadeInEnabled -> Bool
//* triggerAlert -> void
// getSystemAlarmVolume -> Double
//* setAlarmVolume -> Double
//COMPLETE getAlarmVolume - > Double
