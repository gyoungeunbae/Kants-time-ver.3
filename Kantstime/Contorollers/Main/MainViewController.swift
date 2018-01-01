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
    
    var fetchedTask:List<Task>!
    var startTime:[UILabel]!
    var taskName:[UILabel]!
    var colorView:[UIView]!
    var endInteger:Int!
    var startInteger:Int!
    var interval:Int!
    var x = 0
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
        colorView = [UIView]()
        startTime = [UILabel]()
        taskName = [UILabel]()
        if fetchedTask.count != 0 {
            for i in 0..<fetchedTask.count {
                setTaskUI(index: i)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRoutine" {
            clearUI()
        }
    }
    func clearUI() {
        if fetchedTask.count != 0 {
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
                x = 0
            } else {
                endInteger = fetchedTask[index].integerEtime
                startInteger = fetchedTask[index].integerStime
                interval = startInteger-endInteger
                x = interval+150
            }
            let fetchedTaskName = fetchedTask[index].tasktitle
            let fetchedTaskstartTime = fetchedTask[index].starttime
            colorView.append(UIView(frame: CGRect(x: 45, y: 350+x, width: 20, height: 20)))
            let colors = [UIColor.white,UIColor.blue]
            colorView[index].applyGradient(colors: colors)
        
            startTime.append(UILabel(frame: CGRect(x: 100, y: 350+x, width: 100, height: 30)))
            startTime[index].text = fetchedTaskstartTime
            taskName.append(UILabel(frame: CGRect(x: 100, y: 380+x, width: 100, height: 30)))
            taskName[index].text = fetchedTaskName
            self.view.addSubview(startTime[index])
            self.view.addSubview(taskName[index])
            self.view.addSubview(colorView[index])
        
        }
    
    
}

