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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @objc func clicked() {
        print("coke")
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
            let sort = Sorting()
            taskList = sort.mergeSort(list: fetchedTask)

            for i in 0..<fetchedTask.count {
                    setTaskUI(index: i)
                    angleInterval = taskList[i].timeinterval/30
                print(i)
                print(taskList[i].timeinterval)
                print(Realm.Configuration.defaultConfiguration.fileURL!)

                    endAngle = startAngle+CGFloat(angleInterval)*(π/12)
//                    print(angleInterval)
//                    print("****")
                
                    setRoutineBorders(frame: CGRect(x:57, y:250, width: 300, height: 300), task: taskList[i],startAngle: startAngle, endAngle: endAngle, index: i)
                  
                    startAngle = endAngle
                }
            
        }
        //self.view.addSubview(border)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRoutine" {
            clearUI()
        }
    }
    func clearUI() {
        if fetchedTask != nil {
            sum = 0
            y = 0
            for i in 0..<fetchedTask.count {
                startTime[i].removeFromSuperview()
                taskName[i].removeFromSuperview()
                colorView[i].removeFromSuperview()
                startTime[i].isHidden = true
                taskName[i].isHidden = true
                colorView[i].isHidden = true
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
        //start endangle
        
        border = Border(frame: frame, task: task, startAngle: startAngle, endAngle: endAngle,index: index)
        routineBorders.append(border)
        self.view.addSubview(routineBorders[index])
    }
    
    
}

