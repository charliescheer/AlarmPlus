//
//  Snooze.swift
//  AlarmPlus
//
//  Created by Charlie Scheer on 11/10/18.
//  Copyright © 2018 Praxsis. All rights reserved.
//

import UIKit

class Snooze: NSObject {
    private var snoozeLimitEnabled : Bool = false
    private var snoozeLimitCount : Int = 0
    private var snoozeLimitReached : Bool = false
    private var challengeType : String = challenges.code
    var challengeUI : UIView?
    
    func enableSnoozeLimit() {
        snoozeLimitEnabled = true
    }
    
    func disableSnoozeLimit() {
        snoozeLimitEnabled = false
    }
    
    func SnoozeLimitIsEnabled() -> Bool {
        return snoozeLimitEnabled
    }
    
    func increaseSnoozeLimitCount() {
        snoozeLimitCount += 1
    }
    
    func resetSnoozeLimitCount() {
        snoozeLimitCount = 0
    }
    
    func getSnoozeLimit() -> Int {
        return snoozeLimitCount
    }
    
    func snoozeLimitIsReached() {
        snoozeLimitReached = true
    }
    
    func snoozeLimitIsNotReached() {
        snoozeLimitReached = false
    }
    
    func isSnoozeLimitReached() -> Bool {
        return snoozeLimitReached
    }
    
    func setCallengeType(challenge : String) {
        challengeType = challenge
    }
    
    func getChallengeType() -> String {
        return challengeType
    }
    
    func displayChallenge() {
        //display the UIView for the selected Challenge.
        //Challenge functions should be built here?  Maybe in an extension?
    }
    
    func newfunc() {
      challengeType = "test"
    }
    
    
    
}

extension Snooze {
    enum challenges {
        static let walk = "walk"
        static let math = "math"
        static let code = "code"
    }
}

//Snooze
//
//* Methods
//COMPLETE ActivateSnoozeLimit -> Void
//COMPLETE DeactivateSnoozeLimit -> Void
//COMPLETE GetSnoozeLimitEnabledBool -> Bool
//COMPLETE SetSnoozeLimit -> Void
//COMPLETE GetSnoozeLimit -> Int
//COMPLETE GetSnoozeLimitReached -> Bool
//COMPLETE snoozeLimitReached -> Void
//COMPLETE resetSnoozeLimitReached -> Void
//COMPLETE selectChallengeType -> Void
//COMPLETE getChallengeType -> String
//* displayChallenge -> Void
//* getChallengeUIView -> UIView
