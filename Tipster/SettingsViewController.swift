//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Soumya on 4/12/15.
//  Copyright (c) 2015 udaymitra. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var userSettings: UserSettings = UserSettings()

    @IBOutlet weak var tip1Stepper: UIStepper!
    @IBOutlet weak var tip2Stepper: UIStepper!
    @IBOutlet weak var tip3Stepper: UIStepper!
    
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSettings.readFromDefaults()
        setTipStepperValuesFromDefaults()
        showTipPercentages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        userSettings.tipPercent1 = Int(tip1Stepper.value)
        userSettings.tipPercent2 = Int(tip2Stepper.value)
        userSettings.tipPercent3 = Int(tip3Stepper.value)
        
        showTipPercentages()
        userSettings.writeToDefaults()
    }
    
    func setTipStepperValuesFromDefaults() {
        tip1Stepper.value = Double(userSettings.tipPercent1)
        tip2Stepper.value = Double(userSettings.tipPercent2)
        tip3Stepper.value = Double(userSettings.tipPercent3)
    }
    
    func showTipPercentages() {
        tip1Label.text = String(format: "%d%%", userSettings.tipPercent1)
        tip2Label.text = String(format: "%d%%", userSettings.tipPercent2)
        tip3Label.text = String(format: "%d%%", userSettings.tipPercent3)
    }
}
