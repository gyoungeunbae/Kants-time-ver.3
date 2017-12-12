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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = fetchedTask[indexPath.row]
        cell.textLabel?.text = task.tasktitle
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
