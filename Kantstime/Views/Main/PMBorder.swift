//
//  Border.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 02/01/2018.
//  Copyright © 2018 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class PMBorder: UIView {
    
    var count:Int! = Int()
    @IBInspectable var counterColor=UIColor.init (red: 6.0/255.0, green: 131.0/255.0, blue: 145.0/255.0, alpha: 1 )
    var fetchedTask:List<Task>!=List<Task>()
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
    
    
   
    override func draw(_ rect: CGRect) {
        
        var color = UIColor()
        for i in 0..<fetchedTask.count {
            if fetchedTask[i].integerStime >= 720 && fetchedTask[i].integerStime<1440{
                if fetchedTask[i].integerEtime >= 720 && fetchedTask[i].integerEtime<1440{
                    let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
                    counterColor = color.colorListPM(count: i%10)
                    angleInterval = fetchedTask[i].timeinterval/30
                    startAngle = CGFloat((fetchedTask[i].integerStime-720)/30)*π/12+18*π/12
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
                    let testButton = UIButton(frame: path.bounds)
                    testButton.tag = i
                    testButton.backgroundColor = UIColor.clear
                    self.addSubview(testButton)
                    testButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                }
            } else if fetchedTask[i].integerStime < 720 && fetchedTask[i].integerEtime>=720{
                let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
                counterColor = color.colorListPM(count: i%10)
                angleInterval = (fetchedTask[i].integerEtime+1-720)/30
                startAngle = 18*π/12
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
                let testButton = UIButton(frame: path.bounds)
                testButton.tag = i
                testButton.backgroundColor = UIColor.clear
                self.addSubview(testButton)
                testButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
            }
        }
    }
    @objc func pressed(sender: UIButton!) {
        var alertView = UIAlertView()
        alertView.addButton(withTitle: "OK")
        alertView.title = fetchedTask[sender.tag].tasktitle
        alertView.message = "\n\(fetchedTask[sender.tag].starttime) - \(fetchedTask[sender.tag].endtime)"
        alertView.show()
    }
    
    
}
