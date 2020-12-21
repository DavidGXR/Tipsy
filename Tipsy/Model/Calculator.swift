//
//  Calculator.swift
//  Tipsy
//
//  Created by David Im on 12/17/20.
//

import Foundation
import UIKit

struct Calculator {
    
    var billWithTip:Double     = 0.00
    var tip:Double             = 0.00
    var numberOfPeople:Double  = 0.00
    var split:Double           = 0.00
    
    mutating func getTip (inputTip: String) {
        tip = Double(inputTip.dropLast()) ?? 0.00 / 100
    }
        
    mutating func calculateTip(billInput: String, people: String){
        let bill             = Double(billInput) ?? 0.00
        let numOfPeople      = Double(people) ?? 2
        var total: Double    = 0.00
        let totalBillWithTip = bill + (bill * (tip/100))

        total                = totalBillWithTip / numOfPeople
        
        numberOfPeople       = numOfPeople
        split                = total
        billWithTip          = totalBillWithTip
    }
    
    func getSplit() -> String {
        if billWithTip.truncatingRemainder(dividingBy: numberOfPeople) == 0 {
            return String(format: "%.0f", split)
        }else{
            return String(format: "%.2f", split)
        }
    }
    
    func splitInformation() -> String {
        return "Split between \(String(format: "%.0f", numberOfPeople)) people, with \(String(format: "%.0f", tip))% tip"
    }
}
