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
    
        var count:Int! = Int()
        @IBInspectable var counterColor=UIColor.init (red: 6.0/255.0, green: 131.0/255.0, blue: 145.0/255.0, alpha: 1 )
        var fetchedTask:List<Task>!=List<Task>(){
        didSet { setNeedsDisplay() }
        willSet{setNeedsDisplay()}
        }
        var task : Task! = Task()
        var startAngle : CGFloat! = CGFloat()
        var endAngle : CGFloat! = CGFloat()
        var angleInterval:Int! = Int()
        init(frame: CGRect,task:List<Task>) {
            super.init(frame: frame)
            self.fetchedTask = task
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
   
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
                startAngle = π/6
                for i in 0..<fetchedTask.count {
                    let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
                    counterColor=colorList(count: i)
                    angleInterval = fetchedTask[i].timeinterval/30
                    endAngle = startAngle+CGFloat(angleInterval)*(π/12)
                
                    let radius: CGFloat = max(bounds.width, bounds.height)
                    let arcWidth: CGFloat = 20
                    let path = UIBezierPath(arcCenter: center,
                                            radius: radius/2.2 - arcWidth/2.2,
                                             startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: true)
                    
                    path.lineWidth = arcWidth
                    counterColor.setStroke()
                    path.stroke()
                    
                    startAngle=endAngle
                    self.layer.setNeedsDisplay()
        
    }
    }
    
    func drawTaskCircle() {
        let context = UIGraphicsGetCurrentContext()
        for i in 0..<10{
            let order = CGFloat(i)
            let angle = 3*π/2+order*(π/12)
            
            var x = bounds.width/2+sin(angle)*100-10*sin(angle)
            var y = bounds.width/2+cos(angle)*100-10*cos(angle)
            
            let rectangle = CGRect(x: x, y: y, width: 10, height: 10)
            context?.addEllipse(in: rectangle)
            context?.setFillColor(UIColor.red.cgColor)
            context?.fillEllipse(in: rectangle)
        }
    }
    
    
}
