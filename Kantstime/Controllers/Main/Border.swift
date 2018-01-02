//
//  Border.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 02/01/2018.
//  Copyright © 2018 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class Border: UIButton {
        var count=0
        @IBInspectable var counterColor=UIColor.init ( red: 6.0/255.0, green: 131.0/255.0, blue: 145.0/255.0, alpha: 1 )
        var taskList:[Task]!

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
    override func draw(_ rect: CGRect,routineTitle:String,startAngle:CGFloat,endAngle:CGFloat) {
            let realm = try? Realm()
            var fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(routineTitle)'").first?.task
            //var startAngle: CGFloat = 3 * π / 2
            if fetchedTask != nil {
                //let sort = Sorting()
                //taskList = sort.mergeSort(list: fetchedTask!)
                    counterColor=colorList(count: count)
                    startAngle=(CGFloat(taskList[i].integerStime) * π/360) + 3 * π / 2
                    let interval = CGFloat(taskList[i].timeinterval)
                    let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
                    
                    let radius: CGFloat = max(bounds.width, bounds.height)
                    
                    let arcWidth: CGFloat = 50
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
    
}
