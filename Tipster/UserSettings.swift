//
//  UserSettings.swift
//  Tipster
//
//  Created by Soumya on 4/12/15.
//  Copyright (c) 2015 udaymitra. All rights reserved.
//

import Foundation

class UserSettings {
    var tipPercent1: Int = 0
    var tipPercent2: Int = 0
    var tipPercent3: Int = 0
    var lastEnteredBillAmount: Double = 0
    var lastUsedDate: Double = 0
    
    init() {
        readFromDefaults()
    }
    
    func readFromDefaults() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercent1 = defaults.integerForKey("tipPercent1")
        var tipPercent2 = defaults.integerForKey("tipPercent2")
        var tipPercent3 = defaults.integerForKey("tipPercent3")
        
        // default values when they are not set
        if (tipPercent1 == 0) {
            tipPercent1 = 15
        }
        if (tipPercent2 == 0) {
            tipPercent2 = 20
        }
        if (tipPercent3 == 0) {
            tipPercent3 = 25
        }
    
        self.tipPercent1 = tipPercent1
        self.tipPercent2 = tipPercent2
        self.tipPercent3 = tipPercent3
        
        self.lastEnteredBillAmount = defaults.doubleForKey("lastEnteredBillAmount")
        self.lastUsedDate = defaults.doubleForKey("lastUsedDate")
    }
    
    func writeToDefaults() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipPercent1, forKey: "tipPercent1")
        defaults.setInteger(tipPercent2, forKey: "tipPercent2")
        defaults.setInteger(tipPercent3, forKey: "tipPercent3")
        defaults.setDouble(lastEnteredBillAmount, forKey: "lastEnteredBillAmount")
        defaults.setDouble(lastUsedDate, forKey: "lastUsedDate")
        defaults.synchronize()
    }
}