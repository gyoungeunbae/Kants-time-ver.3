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
    var fetchedTask:List<Task>! = List<Task>(){
        didSet{
            self.view.setNeedsDisplay()
        }
        willSet{
            self.view.setNeedsDisplay()
        }
    }
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
    
    @IBOutlet weak var nightCircle: Circle!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("**")
        let date = Date()
        //month.text = date.getMonthName()
        //day.text = date.getDay()
        time.text = date.getTime()
        routineTitle.text = getRountineTitle()
        let realm = try? Realm()
        fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(routineTitle!.text!)'").first?.task
        if fetchedTask != nil {
            setRoutineBorders(frame:CGRect(x:12, y:250, width: 350, height: 350), task: fetchedTask)
            border.setNeedsDisplay()
            border.layoutIfNeeded()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRoutine" {
            if fetchedTask != nil {
                //count = fetchedTask!.count
                clearUI()
            }
        }
    }
    func clearUI() {
        if fetchedTask != nil {
            sum = 0
            y = 0
            border.removeFromSuperview()
            border.isHidden = true
            
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
        border = Border(frame:frame, task: fetchedTask)
        self.view.addSubview(border)
    }
    
    
}
