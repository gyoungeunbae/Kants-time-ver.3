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
    var pmBorder: UIView!=UIView()
    var amBorder: UIView!=UIView()
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
    @IBOutlet weak var currentCircle: UIView!
    @IBOutlet weak var currentTaskTitle: UILabel!
    
    
    
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
        currentCircle.setNeedsDisplay()
        currentCircle.layoutIfNeeded()
        currentTaskTitle.layoutIfNeeded()
        currentTaskTitle.setNeedsDisplay()
        if fetchedTask != nil {
            setRoutineBorders(frame:CGRect(x:22, y:80, width: 330, height: 330), task: fetchedTask)
            pmBorder.setNeedsDisplay()
            pmBorder.layoutIfNeeded()
            amBorder.setNeedsDisplay()
            amBorder.layoutIfNeeded()
            var currentTime = time.text!.split(separator: ":")
            if currentTime[0] == "24" {
                currentTime[0] = "0"
            }
            let integerCurrentTime = Int(currentTime[0])!*60+Int(currentTime[1])!
            let color = UIColor()
            for i in 0..<fetchedTask.count {
                if integerCurrentTime >= fetchedTask[i].integerStime && integerCurrentTime <= fetchedTask[i].integerEtime {
                    currentCircle.backgroundColor = color.colorList(count: i)
                    currentTaskTitle.text = fetchedTask[i].tasktitle
                    currentTaskTitle.textColor = UIColor.white
                    break
                }else {
                    currentCircle.backgroundColor = UIColor.black
                    currentTaskTitle.textColor = UIColor.black
                }
            }
            
        } else {
            currentCircle.backgroundColor = UIColor.black
            currentTaskTitle.textColor = UIColor.black
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRoutine" {
            if fetchedTask != nil {
                clearUI()
            }
        }
    }
    func clearUI() {
        if fetchedTask != nil {
            sum = 0
            y = 0
            pmBorder.removeFromSuperview()
            pmBorder.isHidden = true
            amBorder.removeFromSuperview()
            amBorder.isHidden = true
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
    
    func setRoutineBorders(frame:CGRect,task:List<Task>) {
        pmBorder = PMBorder(frame:frame, task: fetchedTask)
        amBorder = AMBorder(frame:CGRect(x:97, y:157, width: 180, height: 180), task: fetchedTask)
        pmBorder.backgroundColor = UIColor.clear
        amBorder.backgroundColor = UIColor.clear
        self.view.addSubview(pmBorder)
        self.view.addSubview(amBorder)
    }
  
    
}
