//
//  ViewController.swift
//  Tipster
//
//  Created by Soumya on 4/12/15.
//  Copyright (c) 2015 udaymitra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipPercentSegmentControl: UISegmentedControl!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var settingsBarButton: UIBarButtonItem!
    
    @IBOutlet weak var split2Label: UILabel!
    @IBOutlet weak var split3Label: UILabel!
    @IBOutlet weak var split4Label: UILabel!
    
    var userSettings: UserSettings = UserSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsBarButton.title = NSString(string: "\u{2699}")
        totalLabel.text = "0.00"
 
        updateViewWithUserSetTipPercentages()
        var timeSinceLastUsed = NSDate().timeIntervalSinceReferenceDate - userSettings.lastUsedDate

        if (userSettings.lastEnteredBillAmount > 0 && timeSinceLastUsed < 600) {
            // last used less than 10 minutes ago
            billAmountField.text = String(format: "%.2f", userSettings.lastEnteredBillAmount)
            displayResults(true)
        } else {
            displayResults(false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBillAmountEditingChanged(sender: AnyObject) {
        calculateTipAndShowView()
    }
    
    func calculateTipAndShowView() {
        var billAmount = (billAmountField.text as NSString).doubleValue
        
        userSettings.lastEnteredBillAmount = billAmount
        userSettings.lastUsedDate = NSDate().timeIntervalSinceReferenceDate
        userSettings.writeToDefaults()

        if (billAmount == 0) {
            displayResults(false)
            billAmountField.text = ""
            return
        }
        
        displayResults(true)
        var tipPercentages = [userSettings.tipPercent1, userSettings.tipPercent2, userSettings.tipPercent3]
        var tipPercentToUse = tipPercentages[tipPercentSegmentControl.selectedSegmentIndex]
        
        var tipAmount = Double(tipPercentToUse) * billAmount / 100
        var totalAmount = billAmount + tipAmount
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
        split2Label.text = String(format: "$%.2f", totalAmount / 2)
        split3Label.text = String(format: "$%.2f", totalAmount / 3)
        split4Label.text = String(format: "$%.2f", totalAmount / 4)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateViewWithUserSetTipPercentages() {
        tipPercentSegmentControl.setTitle(
            String(format: "%d%%", userSettings.tipPercent1),
            forSegmentAtIndex: 0)
        
        tipPercentSegmentControl.setTitle(
            String(format: "%d%%", userSettings.tipPercent2),
            forSegmentAtIndex: 1)

        tipPercentSegmentControl.setTitle(
            String(format: "%d%%", userSettings.tipPercent3),
            forSegmentAtIndex: 2)
    }
    
    func displayResults(enable: Bool) {
        if (enable) {
            UIView.animateWithDuration(0.2, animations: {
                self.billAmountField.frame.origin.y = 80
                self.tipPercentSegmentControl.hidden = false
                // results view is the backdrop div with a darker color
                // if we hide this, then user cant see the text written on the div
                self.resultsView.hidden = false
            })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.billAmountField.frame.origin.y = 125
                self.tipPercentSegmentControl.hidden = true
                self.resultsView.hidden = true
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        userSettings.readFromDefaults()
        updateViewWithUserSetTipPercentages()
        calculateTipAndShowView()
    }
}

