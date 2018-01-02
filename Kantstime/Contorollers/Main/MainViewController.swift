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
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var baseCircle: Circle!
    
    @IBOutlet weak var border: Border!
    var sum:Int!
    var taskList:[Task]!
    var fetchedTask:List<Task>!
    var routineBorders:[UIButton]!
    var startTime:[UILabel]!
    var taskName:[UILabel]!
    var colorView:[UIView]!
    var endInteger:Int!
    var startInteger:Int!
    var interval:Int!
    var y:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //view.layer.addSublayer(shapeLayer)
       let buttonTest = UIButton(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
        buttonTest.layer.cornerRadius = buttonTest.bounds.width/2
        buttonTest.layer.borderColor = UIColor.orange.cgColor
        buttonTest.layer.borderWidth = 40
        buttonTest.backgroundColor = UIColor.white
        buttonTest.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        //self.view.addSubview(buttonTest)
        
    }
    @objc func clicked() {
        print("coke")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        colorView = [UIView]()
        startTime = [UILabel]()
        taskName = [UILabel]()
        routineBorders = [UIButton]()
        let date = Date()
        month.text = date.getMonthName()
        day.text = date.getDay()
        time.text = date.getTime()
        routineTitle.text = getRountineTitle()
        let realm = try? Realm()
        fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(routineTitle!.text!)'").first?.task
        if fetchedTask != nil {
            let sort = Sorting()
            taskList = sort.mergeSort(list: fetchedTask)
                for i in 0..<fetchedTask.count {
                    setTaskUI(index: i)
                }
        }
        
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
            self.view.addSubview(startTime[index])
            self.view.addSubview(taskName[index])
            self.view.addSubview(colorView[index])
      
    }
    
    
}

