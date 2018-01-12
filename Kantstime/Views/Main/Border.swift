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
    
    
    func colorList(count: Int)->UIColor
    {
        if count==0
        {
             counterColor=UIColor.init ( red: 248.0/255.0, green: 252.0/255.0, blue: 253.0/255.0, alpha: 1 )
        }
        else if count==1
        {
            
            counterColor=UIColor.init ( red: 227.0/255.0, green: 236.0/255.0, blue: 253.0/255.0, alpha: 1 )
           
            
        }
        else if count==2
        {
            counterColor=UIColor.init ( red: 195.0/255.0, green: 210.0/255.0, blue: 228.0/255.0, alpha: 1 )
            return counterColor
        }
        else if count==3
        {
            counterColor=UIColor.init ( red: 166.0/255.0, green: 187.0/255.0, blue: 216.0/255.0, alpha: 1 )
            
        }
        else if count==4
        {
            counterColor=UIColor.init ( red: 142.0/255.0, green: 149.0/255.0, blue: 195.0/255.0, alpha: 1 )
            
        }
        else if count==5
        {
            counterColor=UIColor.init ( red: 130.0/255.0, green: 106.0/255.0, blue: 174.0/255.0, alpha: 1 )
            
        }
        else if count==6
        {
            counterColor=UIColor.init ( red: 123.0/255.0, green: 98.0/255.0, blue: 131.0/255.0, alpha: 1 )
            
        }
        else if count==7
        {
            counterColor=UIColor.init ( red: 103.0/255.0, green: 128.0/255.0, blue: 156.0/255.0, alpha: 1 )
            
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
            startAngle=endAngle
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
    @objc func pressed(sender: UIButton!) {
        print(">>>>>>>")
        print(sender.tag)
        var alertView = UIAlertView()
        alertView.addButton(withTitle: "test")
        alertView.title = fetchedTask[sender.tag].tasktitle
        alertView.message = "\n\(fetchedTask[sender.tag].starttime) ~ \(fetchedTask[sender.tag].endtime)"
        alertView.show()
    }
    
    
}
