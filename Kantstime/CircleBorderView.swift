//
//  CircleBorderView.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 17/11/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class CircleBorderView: UIView {
    var count=0
    @IBInspectable var counterColor=UIColor.init ( red: 6.0/255.0, green: 131.0/255.0, blue: 145.0/255.0, alpha: 1 )
    //let ad = UIApplication.sharedApplication().delegate as? AppDelegate
    

    //let taskdata=try! Realm().objects(Task.self)
    func colorList(count: Int)->UIColor
    {
        
        if count==0
        {
            counterColor=UIColor.init ( red: 33.0/255.0, green: 255.0/255.0, blue: 194.0/255.0, alpha: 1 )
            
            
        }
        else if count==1
        {
            counterColor=UIColor.init ( red: 255.0/255.0, green: 33.0/255.0, blue: 199.0/255.0, alpha: 1 )
            
        }
        else if count==2
        {
            counterColor=UIColor.init ( red: 33.0/255.0, green: 203.0/255.0, blue: 255.0/255.0, alpha: 1 )
            return counterColor
        }
        else if count==3
        {
            counterColor=UIColor.init ( red: 255.0/255.0, green: 33.0/255.0, blue: 73.0/255.0, alpha: 1 )
            
        }
        else if count==4
        {
            counterColor=UIColor.init ( red: 245.0/255.0, green: 255.0/255.0, blue: 33.0/255.0, alpha: 1 )
            
        }
        else if count==5
        {
            counterColor=UIColor.init ( red: 145.0/255.0, green: 33.0/255.0, blue: 255.0/255.0, alpha: 1 )
            
        }
        
        return counterColor
    }
    override func draw(_ rect: CGRect) {
        var startAngle: CGFloat = 3 * π / 2
        let ad = UIApplication.shared.delegate as? AppDelegate
        let taskdata = ad?.taskdata
        let setTaskData = (ad?.taskdata?.count)!
        for i in 0..<setTaskData{
            count=(i+1)%7
            counterColor=colorList(count: count)
            startAngle=(CGFloat(taskdata![i].integerStime) * π/360) + 3 * π / 2
            
            let interval = CGFloat(taskdata![i].timeinterval)
            let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
            
            let radius: CGFloat = max(bounds.width, bounds.height)
            
            let arcWidth: CGFloat = 30
            let endAngle: CGFloat =  (startAngle)+(interval * π/360)
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius/2.2 - arcWidth/2.2,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            
            path.lineWidth = arcWidth
            counterColor.setStroke()
            path.stroke()
            startAngle=endAngle
         
        }
    }
    

}
