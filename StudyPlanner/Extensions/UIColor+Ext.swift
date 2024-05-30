//
//  UIColor+Ext.swift
//  StudyPlanner
//
//  Created by Quinn on 15/05/2024.
//

import UIKit

extension UIColor {
   
    func lightenByPercentage(by percentage: Int) -> UIColor {
        var red: CGFloat    = 0
        var green: CGFloat  = 0
        var blue: CGFloat   = 0
        var alpha: CGFloat  = 0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let percentage  = CGFloat(min(percentage, 100))
            let multiplier  = CGFloat(percentage/100)
            return UIColor(red: ((1 - red) * multiplier) + red,
                           green: ((1 - green) * multiplier) + green,
                           blue: ((1 - blue) * multiplier) + blue,
                           alpha: alpha)
        }
        return self
    }

    func darkenByPercentage(by percentage: Int) -> UIColor {
        var red: CGFloat    = 0
        var green: CGFloat  = 0
        var blue: CGFloat   = 0
        var alpha: CGFloat  = 0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let percentage  = CGFloat(min(percentage, 100))
            let multiplier  = CGFloat(percentage/100)
            return UIColor(red: red * (1 - multiplier),
                           green: green * (1 - multiplier),
                           blue: blue * (1 - multiplier),
                           alpha: alpha)
        }
        return self
    }
}
