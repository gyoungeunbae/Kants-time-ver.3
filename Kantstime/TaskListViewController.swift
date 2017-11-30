//
//  TaskListViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 25/11/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
let taskUserDefault = "taskUserDefault"
class TaskListViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    var tasks = [Taskmodel]() {
        didSet {
            self.saveAll()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAll()
    }

    func saveAll() {
        let data = self.tasks.map {
            [
                "tasktitle": $0.tasktitle,
                "starttime": $0.starttime,
                "endtime": $0.endtime
            ]
        }
       let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: taskUserDefault)
        userDefaults.synchronize()
        
    }
    
    func loadAll() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: taskUserDefault) as? [[String:AnyObject]] else {
            return
        }
        self.tasks = data.flatMap {
            guard let title = $0["tasktitle"] as? String else {
                return nil
            }
            guard let starttime = $0["starttime"] as? String else {
                return nil
            }
            guard let endtime = $0["endtime"] as? String else {
                return nil
            }
           
         return Taskmodel(tasktitle: title, starttime: starttime, endtime: endtime)
        }
    }
    
        
    }
    


extension TaskListViewController:UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let task = self.tasks[indexPath.row]
//        cell?.textLabel?.text = task.tasktitle
//        cell?.textLabel?.text = task.starttime
//        cell?.textLabel?.text = task.endtime
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
}

extension TaskListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        self.tasks[indexPath.row] = task
        self.taskTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
