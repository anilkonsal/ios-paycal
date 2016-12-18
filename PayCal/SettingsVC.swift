//
//  SettingsVC.swift
//  PayCal
//
//  Created by Anil Konsal on 17/12/16.
//  Copyright © 2016 Anil Konsal. All rights reserved.
//

import UIKit

var includesSuper: Bool = false
var superPercentage: Double = 9.5
var studentLoan: Bool = false
var nonResident: Bool = false
var helpTsl: Bool = false
var noTaxFreeThreshold: Bool = false

class SettingsVC: UITableViewController {

    @IBOutlet weak var includesSuperSwt: UISwitch!
    @IBOutlet weak var superPercentageTxt: UITextField!
    @IBOutlet weak var nonResidentSwt: UISwitch!
    @IBOutlet weak var studentLoanSwt: UISwitch!
    
    @IBOutlet weak var helpTslSwt: UISwitch!
    @IBOutlet weak var noTaxFreeThresholdSwt: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        includesSuperSwt.isOn = includesSuper
        nonResidentSwt.isOn = nonResident
        studentLoanSwt.isOn = studentLoan
        helpTslSwt.isOn = helpTsl
        noTaxFreeThresholdSwt.isOn = noTaxFreeThreshold
        superPercentageTxt.text = String(superPercentage)
    }

    @IBAction func includeSuperSwtChanged(_ sender: UISwitch) {
        includesSuper = includesSuperSwt.isOn
    }
    
    @IBAction func superPercentageChanged(_ sender: Any) {
        superPercentage = Double(superPercentageTxt.text!)!
    }
    
    @IBAction func nonResidentSwtChanged(_ sender: UISwitch) {
        nonResident = nonResidentSwt.isOn
    }
    
    @IBAction func studentLoanSwtChanged(_ sender: UISwitch) {
        studentLoan = studentLoanSwt.isOn
    }
    
    @IBAction func helpTslSwtChanged(_ sender: UISwitch) {
        helpTsl = helpTslSwt.isOn
    }
    
    @IBAction func noTaxFreeThresholdSwtChanged(_ sender: UISwitch) {
        noTaxFreeThreshold = noTaxFreeThresholdSwt.isOn
    }
    
}
