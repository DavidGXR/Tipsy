//
//  Extensions.swift
//  Tipsy
//
//  Created by David Im on 12/16/20.
//

import Foundation
import UIKit

extension UIColor {
    
    static let universalGreen                   = UIColor().colorFromHex("008854")
    static let universalYellow                  = UIColor().colorFromHex("FFCE00")
    static let recentsTableViewBackground       = UIColor().colorFromHex("262626")
    
    func colorFromHex (_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green:  CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue:  CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha:  1)
    }
}

extension UIAlertController {
    func howToEnableLocationService() {
        let alertBox = UIAlertController(title: "You Can Enable Location Service Later", message: "You can enable location service later by going to: Setting -> Privacy -> Location Services -> Find \"Tipsy\" -> Allow Location Access", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertBox.addAction(okButton)
    }
}
