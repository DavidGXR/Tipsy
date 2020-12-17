//
//  Extensions.swift
//  Tipsy
//
//  Created by David Im on 12/16/20.
//

import Foundation
import UIKit

extension UIColor {
    
    static let greenBackgroundColor = UIColor().colorFromHex("008854")
    static let universalYellow      = UIColor().colorFromHex("FFCE00")
    
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
