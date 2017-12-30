//
//  TaskListViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 10/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//
import UIKit
import RealmSwift

class TaskListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var name:String!
    @IBOutlet weak var routineNameLabel: UILabel!
    var fetchedTask:List<Task>!
    var existingRoutine:Routine!
    @IBOutlet weak var tableView: UITableView!
    var taskList:[Task]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let realm = try? Realm()
        let name = existingRoutine.routinetitle
        fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(name)'").first?.task
        routineNameLabel.text = existingRoutine.routinetitle
        tableView.rowHeight = 200
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedTask?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskTableViewCell
        
        let count = indexPath.row%6
        cell.colorChip.applyGradient(colors:view.colorList(index: count))
        let sort = Sorting()
        taskList = sort.mergeSort(list: fetchedTask)
        
        cell.taskTitle.text = taskList[indexPath.row].tasktitle
        cell.startTime.text = (taskList[indexPath.row].starttime)
        cell.endTime.text = taskList[indexPath.row].endtime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        performSegue(withIdentifier: "editSegue", sender: task)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try? Realm()
            var task = taskList[indexPath.row]
            for i in 0 ..< fetchedTask.count {
                if task.starttime == fetchedTask[i].starttime {
                    task = fetchedTask[i]
                }
            }
            try? realm?.write {
                realm?.delete(task)
                tableView.reloadData()
            }
        }
    }
   
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func openAddVC(_ sender: Any) {
        let routine  = existingRoutine.routinetitle
        print(routine)
        performSegue(withIdentifier: "passRoutineName", sender: routine)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            if let destination = segue.destination as? AddTaskViewController {
                if let task = sender as? Task {
                    destination.existingTask = task
                }
            }
        }
        if segue.identifier == "passRoutineName" {
            if let destination = segue.destination as? AddTaskViewController {
                if let routine = sender as? String{
                    destination.passedRoutineName = routine
                }
            }
        }
        
    }
}

