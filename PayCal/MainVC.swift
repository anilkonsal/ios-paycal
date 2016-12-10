//
//  ViewController.swift
//  PayCal
//
//  Created by Anil Konsal on 09/12/16.
//  Copyright © 2016 Anil Konsal. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var salaryTypeYearlyBtn: UIView!
    @IBOutlet weak var salaryTypeDailyBtn: UIView!
    @IBOutlet weak var salaryAmountTxt: UITextField!
    @IBOutlet weak var tabYearlyBtn: UIButton!
    @IBOutlet weak var tabMonthlyBtn: UIButton!
    @IBOutlet weak var tabDailyBtn: UIButton!
    @IBOutlet weak var tabFortnightlyBtn: UIButton!
    @IBOutlet weak var tabWeeklyBtn: UIButton!
    @IBOutlet weak var takeHomeAmtLbl: UILabel!
    @IBOutlet weak var superAmountLbl: UILabel!
    @IBOutlet weak var totalTaxesAmtLbl: UILabel!
    @IBOutlet weak var incomeTaxAmtLbl: UILabel!
    @IBOutlet weak var medicareAmtLbl: UILabel!
    @IBOutlet weak var otherTaxesAmtLbl: UILabel!
    @IBOutlet weak var taxOffsetLbl: UILabel!
    @IBOutlet weak var triangleImg: UIImageView!
    
    private let FREQUENCY_YEARLY = "yearly"
    private let FREQUENCY_MONTHLY = "monthly"
    private let FREQUENCY_FORTNIGHTLY = "fortnightly"
    private let FREQUENCY_WEEKLY = "weekly"
    private let FREQUENCY_DAILY = "daily"
    
    var frequency: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequency = FREQUENCY_YEARLY
        
    }
//    @IBAction func salaryAmountEntered(_ sender: Any) {
//        fetchValuesAndDisplayResults()
//    }
    @IBAction func salaryAmountChanged(_ sender: Any) {
        fetchValuesAndDisplayResults()
    }
    @IBAction func tabYearlyBtnPressed(_ sender: Any) {
        frequency = FREQUENCY_YEARLY
        activateTab(tab: tabYearlyBtn)
        fetchValuesAndDisplayResults()
    }
    @IBAction func tabMonthlyBtnPressed(_ sender: Any) {
        frequency = FREQUENCY_MONTHLY
        activateTab(tab: tabMonthlyBtn)
        fetchValuesAndDisplayResults()
    }
    
    @IBAction func tabDailyBtnPressed(_ sender: Any) {
        frequency = FREQUENCY_DAILY
        activateTab(tab: tabDailyBtn)
        fetchValuesAndDisplayResults()
    }
    @IBAction func tabWeeklyBtnPressed(_ sender: Any) {
        frequency = FREQUENCY_WEEKLY
        activateTab(tab: tabWeeklyBtn)
        fetchValuesAndDisplayResults()
    }
    
    @IBAction func tabFortnightlyBtnPressed(_ sender: Any) {
        
        frequency = FREQUENCY_FORTNIGHTLY
        activateTab(tab: tabFortnightlyBtn)
        fetchValuesAndDisplayResults()

    }
    func fetchValuesAndDisplayResults()
    {
        if (salaryAmountTxt.text == "") {
            return;
        }
        
        let salary: Double = Double(salaryAmountTxt.text!)!
        let superPer: Double = 9.5
        let medicarePer: Double = 2
        
        let (takeHomeAmt, income_tax, superAmount, medicareAmt, totalTaxesAmt,
            otherTaxesAmt, taxOffsetAmt) =
                calculate(salary: salary, superPer: superPer, medicarePer: medicarePer, frequency: self.frequency)
        
        
        incomeTaxAmtLbl.text = String(income_tax)
        superAmountLbl.text = String(superAmount)
        medicareAmtLbl.text = String(medicareAmt)
        takeHomeAmtLbl.text = String(takeHomeAmt)
        totalTaxesAmtLbl.text = String(totalTaxesAmt)
        otherTaxesAmtLbl.text = String(otherTaxesAmt)
        taxOffsetLbl.text = String(taxOffsetAmt)

    }

    func calculate(salary: Double, superPer: Double, medicarePer: Double, frequency: String) ->
            (takeHomeAmt: Double, income_tax: Double, superAmount: Double,
                medicareAmt: Double,totalTaxesAmt: Double, otherTaxesAmt: Double,
                taxOffsetAmt: Double)
    {
        var income_tax = 0.0
        
        if salary <= 18200 {
            income_tax = 0.0
        }
        
        if salary > 18200 && salary <= 37000 {
            income_tax += (salary - 18200) * 19/100
        }
        
        if salary > 37000 && salary <= 87000 {
            income_tax += (37000-18200) * 19/100
            income_tax += (salary - 37000) * 32.5/100
        }
        
        if salary > 87000 && salary <= 180000 {
            income_tax += ((87000 - 37000) * 32.5/100)
            income_tax += ((37000-18200) * 19/100)
            income_tax += (salary - 87000) * 37/100
        }
        
        if salary > 180000 {
            income_tax +=  ((180000 - 87000) * 37/100)
            income_tax += ((87000 - 37000) * 32.5/100)
            income_tax += ((37000-18200) * 19/100)
            income_tax += (salary - 180000) * 45/100
        }
        
        
        
        
        
        var superAmount = salary * superPer/100.0
        var medicareAmt = salary * medicarePer/100.0
        var takeHomeAmt = salary - (income_tax + medicareAmt)
        var totalTaxesAmt = income_tax + medicareAmt
        var otherTaxesAmt = 0.0
        var taxOffsetAmt = 0.0
        
        if frequency == FREQUENCY_MONTHLY {
            income_tax /= 12
            superAmount /= 12
            medicareAmt /= 12
            takeHomeAmt /= 12
            totalTaxesAmt /= 12
            otherTaxesAmt /= 12
            taxOffsetAmt /= 12
        } else if frequency == FREQUENCY_FORTNIGHTLY {
            income_tax /= 26
            superAmount /= 26
            medicareAmt /= 26
            takeHomeAmt /= 26
            totalTaxesAmt /= 26
            otherTaxesAmt /= 26
            taxOffsetAmt /= 26
        } else if frequency == FREQUENCY_WEEKLY {
            income_tax /= 52
            superAmount /= 52
            medicareAmt /= 52
            takeHomeAmt /= 52
            totalTaxesAmt /= 52
            otherTaxesAmt /= 52
            taxOffsetAmt /= 52
        }
        else if frequency == FREQUENCY_DAILY {
            income_tax /= 365
            superAmount /= 365
            medicareAmt /= 365
            takeHomeAmt /= 365
            totalTaxesAmt /= 365
            otherTaxesAmt /= 365
            taxOffsetAmt /= 365
        }
        
        income_tax = round(income_tax)
        superAmount = round(superAmount)
        medicareAmt = round(medicareAmt)
        takeHomeAmt = round(takeHomeAmt)
        totalTaxesAmt = round(totalTaxesAmt)
        otherTaxesAmt = round(otherTaxesAmt)
        taxOffsetAmt = round(taxOffsetAmt)
        
        
        return (takeHomeAmt, income_tax, superAmount, medicareAmt, totalTaxesAmt,
                otherTaxesAmt, taxOffsetAmt)
    }
    
    func activateTab(tab: UIButton)
    {
        tabYearlyBtn.alpha = 0.3
        tabMonthlyBtn.alpha = 0.3
        tabFortnightlyBtn.alpha = 0.3
        tabWeeklyBtn.alpha = 0.3
        tabDailyBtn.alpha = 0.3
        
        tab.alpha = 1.0
        
        triangleImg.center = tab.center
        triangleImg.frame.origin.y = -5
        
    }

    


}

