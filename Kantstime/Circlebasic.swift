//
//  Circlebasic.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 10/11/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
class Circlebasic: UIButton {
    @IBInspectable var circleOutLineColor: UIColor = UIColor.black
    override func draw(_ rect:CGRect){
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
        
        
        UIColor.black.setFill()//안쪽 원 색깔
        path.lineWidth = arcWidth
        path.fill()
        circleOutLineColor.setStroke()
        path.stroke()
        
        
    }
    
}


