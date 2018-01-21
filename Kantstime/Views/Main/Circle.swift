//
//  Circle.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 01/01/2018.
//  Copyright © 2018 gyoungeun ola bae. All rights reserved.
//

import UIKit
let π:CGFloat = CGFloat(M_PI)

class Circle: UIView {

     @IBInspectable var circleOutLineColor: UIColor = UIColor()
    
     override func draw(_ rect: CGRect) {
        shadowCircle()
     
     }
    func setNigthCircle() {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 0.7
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2.4 - arcWidth/2.4,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        
        let colors = [UIColor.black.cgColor,UIColor.white.cgColor]
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineCap = "round"
        shape.lineWidth = arcWidth
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shape)
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        gradient.colors = colors
        gradient.mask = shape
        self.layer.addSublayer(gradient)
        
    }
    func setDaytimeCircle() {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = min(bounds.width-100, bounds.height-100)
        let arcWidth: CGFloat = 0.7
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2.4 - arcWidth/2.4,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        
        let colors = [UIColor.init(red: 255.0/255.0, green: 154.0/255.0, blue: 158.0/255.0, alpha: 1).cgColor,UIColor.init(red: 250.0/255.0, green: 208.0/255.0, blue: 196.0/255.0, alpha: 1).cgColor]
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineCap = "round"
        shape.lineWidth = arcWidth
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shape)
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        gradient.colors = colors
        gradient.mask = shape
        self.layer.addSublayer(gradient)
    }
    func shadowCircle() {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = min(bounds.width-100, bounds.height-100)
        let arcWidth: CGFloat = 0.7
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2.4 - arcWidth/2.4,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        UIColor.white.setStroke()
        
        path.stroke()
    }

}
