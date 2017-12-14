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
 
    var fetchedTask:Results<Task>!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let realm = try? Realm()
        fetchedTask = (realm?.objects(Task.self).sorted(byKeyPath: "integerStime", ascending: true))!
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TaskTableViewCell
        let task = fetchedTask[indexPath.row]

        let count = indexPath.row%6
        if count==0 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 33.0/255.0, green: 255.0/255.0, blue: 194.0/255.0, alpha: 1 )
        }else if count==1 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 255.0/255.0, green: 33.0/255.0, blue: 199.0/255.0, alpha: 1 )
        }else if count==2 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 33.0/255.0, green: 203.0/255.0, blue: 255.0/255.0, alpha: 1 )
        }else if count==3 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 255.0/255.0, green: 33.0/255.0, blue: 73.0/255.0, alpha: 1 )
        }else if count==4 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 245.0/255.0, green: 255.0/255.0, blue: 33.0/255.0, alpha: 1 )
        }else if count==5 {
            cell.colorChip.backgroundColor=UIColor.init ( red: 145.0/255.0, green: 33.0/255.0, blue: 255.0/255.0, alpha: 1 )
        }
        
        cell.taskTitle.text = task.tasktitle
        cell.startTime.text = task.starttime + "   -"
        cell.endTime.text = task.endtime
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = fetchedTask[indexPath.row]
        performSegue(withIdentifier: "editSegue", sender: task)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try? Realm()
            try? realm?.write {
                let fetched = fetchedTask[indexPath.row]
                realm?.delete(fetched)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let destination = segue.destination as? AddTaskViewController {
                if let task = sender as? Task {

                    destination.existingTask = task
                }
            }
        }
    }
}
