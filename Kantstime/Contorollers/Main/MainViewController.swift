//
//  MainViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 31/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class MainViewController: UIViewController {
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var routineTitle: UILabel!
    
    var border: UIButton!=UIButton()
    var startAngle:CGFloat! = CGFloat()
    var endAngle:CGFloat! = CGFloat()
    var sum:Int! = Int()
    var taskList:[Task]! = [Task]()
    var fetchedTask:List<Task>! = List<Task>()
    var routineBorders:[UIButton]! = [UIButton]()
    var startTime:[UILabel]! = [UILabel]()
    var taskName:[UILabel]! = [UILabel]()
    var colorView:[UIView]! = [UIView]()
    var endInteger:Int! = Int()
    var startInteger:Int! = Int()
    var interval:Int = Int()
    var angleInterval : Int! = Int()
    var y:Int! = Int()
    var count:Int! = Int()
    var reCount:Int! = Int()

    @IBOutlet weak var nightCircle: Circle!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        month.text = date.getMonthName()
        day.text = date.getDay()
        time.text = date.getTime()
        routineTitle.text = getRountineTitle()
        let realm = try? Realm()
        fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(routineTitle!.text!)'").first?.task
        startAngle = π/6
        if fetchedTask != nil {
            for i in 0..<fetchedTask.count {
                    angleInterval = fetchedTask[i].timeinterval/30
                    endAngle = startAngle+CGFloat(angleInterval)*(π/24)
                    setRoutineBorders(frame: CGRect(x:12, y:250, width: 350, height: 350), task: fetchedTask[i],startAngle: startAngle, endAngle: endAngle, index: i)
                    startAngle = endAngle
                reCount = fetchedTask.count

                }

        }
        if count != reCount{
         print("what\(reCount)")
            print("is?\(count)")
            for i in 0..<routineBorders.count {
                routineBorders[i].isHidden = false
                routineBorders[i].setNeedsDisplay()
            }
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRoutine" {
            if fetchedTask != nil {
                count = fetchedTask!.count
                clearUI()
            }
        }
    }
    func clearUI() {
        if fetchedTask != nil {
            sum = 0
            y = 0
            for i in 0..<fetchedTask.count {
              routineBorders[i].removeFromSuperview()
              routineBorders[i].isHidden = true
            }
        }
    }
 
    
    func getRountineTitle() -> String {
        let realm = try? Realm()
        if var routineName  = try? realm?.objects(Routine.self).filter("routineButton = true").first?.routinetitle {
            if routineName == nil {
                routineName = " "
                return (routineName as? String)!
            }
            return (routineName as? String)!

        }
        
    }
    func setTaskUI(index: Int) {
            if index == 0 {
                sum = 0
                y = 0
            } else {
                endInteger = taskList[index-1].integerEtime
                startInteger = taskList[index].integerStime
                interval = startInteger-endInteger
                y = interval+50
                sum=y+sum
            }
            let fetchedTaskName = taskList[index].tasktitle
            let fetchedTaskstartTime = taskList[index].starttime
            colorView.append(UIView(frame: CGRect(x: 45, y: 360+sum, width: 20, height: 20)))
            let colors = [UIColor.white,UIColor.blue]
            colorView[index].applyGradient(colors: colors)
        
            startTime.append(UILabel(frame: CGRect(x: 100, y: 360+sum, width: 100, height: 30)))
        
            startTime[index].text = fetchedTaskstartTime
            taskName.append(UILabel(frame: CGRect(x: 100, y: 390+sum, width: 100, height: 30)))
            taskName[index].text = fetchedTaskName
            //self.view.addSubview(startTime[index])
            //self.view.addSubview(taskName[index])
            //self.view.addSubview(colorView[index])
      
    }
    func setRoutineBorders(frame:CGRect,task:Task,startAngle:CGFloat, endAngle: CGFloat, index:Int) {
        border = Border(frame: frame, task: task, startAngle: startAngle, endAngle: endAngle,index: index)
        routineBorders.append(border)
        self.view.addSubview(routineBorders[index])


    }

    
}

