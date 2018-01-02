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

     @IBInspectable var circleOutLineColor: UIColor = UIColor.gray
    
     override func draw(_ rect: CGRect) {
     
     let center = CGPoint(x:bounds.width/2, y: bounds.height/2)//view 위치의 가운데
     let radius: CGFloat = max(bounds.width, bounds.height)//지름
     let arcWidth: CGFloat = 1//굵기
     let startAngle: CGFloat = 3 * π / 2
     let endAngle: CGFloat = 7 * π / 2
     var path = UIBezierPath(arcCenter: center,
     radius: radius/2.4 - arcWidth/2.4,
     startAngle: startAngle,
     endAngle: endAngle,
     clockwise: true)
     
     
     UIColor.clear.setFill()//안쪽 원 색깔
     path.lineWidth = arcWidth
     path.fill()
     circleOutLineColor.setStroke()
     path.stroke()
     
     
     }
}
