//
//  CircleLine.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 02/01/2018.
//  Copyright © 2018 gyoungeun ola bae. All rights reserved.
//

import UIKit

class CircleLine: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        
        for i in 0..<48{
            let order = CGFloat(i)
            let angle = 3*π/2+order*(π/24)
            path.move(to: CGPoint(x: bounds.width/2, y: bounds.width/2))
            path.addLine(to: CGPoint(x: bounds.width/2+sin(angle)*126, y: bounds.width/2+cos(angle)*126))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            UIColor.init(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 0.4).setStroke()
            shapeLayer.lineWidth = 1
            path.stroke()
        }
    }

}
