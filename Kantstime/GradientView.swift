//
//  GradientView.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 26/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit


extension UIView {
    func applyGradient(colors: [UIColor]) -> Void {
        self.applyGradient(colors: colors, locations: nil)
    }
    
    func applyGradient(colors: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x:0,y:0.5)
        gradient.endPoint = CGPoint(x:1,y:0.8)
        gradient.locations = locations
        gradient.cornerRadius = self.bounds.width/2
        self.layer.addSublayer(gradient)
    }
    func colorList(index: Int) -> [UIColor]{
    
        switch index {
        case 0:
            return[UIColor.init(red: 255.0/255.0, green: 154.0/255.0, blue: 158.0/255.0, alpha: 1),UIColor.init(red: 250.0/255.0, green: 208.0/255.0, blue: 196.0/255.0, alpha: 1)]
        case 1:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        case 2:
            return[UIColor.init(red: 125.0/255.0, green: 226.0/255.0, blue: 252.0/255.0, alpha: 0.6),UIColor.init(red: 185.0/255.0, green: 182.0/255.0, blue: 229.0/255.0, alpha: 1)]
        case 3:
            return[UIColor.init(red: 250.0/255.0, green: 208.0/255.0, blue: 196.0/255.0, alpha: 1),UIColor.init(red: 255.0/255.0, green: 209.0/255.0, blue: 255.0/255.0, alpha: 1)]
            
        case 4:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        case 5:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        case 6:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        case 7:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        case 8:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
            
        case 9:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
            
        case 10:
           return[UIColor.init(red: 255.0/255.0, green: 110.0/255.0, blue: 127.0/255.0, alpha: 0),UIColor.init(red: 191.0/255.0, green: 233.0/255.0, blue: 2550.0/255.0, alpha: 0.51),UIColor.init(red: 255.0/255.0, green: 110.0/255.0, blue: 127.0/255.0, alpha: 1)]
        case 11:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
            
        default:
            return[UIColor.init(red: 247.0/255.0, green: 112.0/255.0, blue: 98.0/255.0, alpha: 1),UIColor.init(red: 254.0/255.0, green: 81.0/255.0, blue: 150.0/255.0, alpha: 1)]
        }
    }
   

}
