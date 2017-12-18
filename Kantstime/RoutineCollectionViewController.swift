//
//  RoutineCollectionViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 14/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift

class RoutineCollectionViewController: ViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var routineCollectionView: UICollectionView!
    var routineNameFromTextField:UITextField!
    
    var fetchedRoutine : Results<Routine>!
    override func viewDidLoad() {
        super.viewDidLoad()
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
       
        let realm = try? Realm()
        fetchedRoutine = (realm?.objects(Routine.self))?.sorted(byKeyPath: "routinetitle", ascending: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        routineCollectionView.reloadData()
    }
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x:0,y:0.5)
        layer.endPoint = CGPoint(x:1,y:0.5)
        layer.colors = [
            UIColor.init ( red: 99.0/255.0, green: 47.0/255.0, blue: 191.0/255.0, alpha: 1 ).cgColor,UIColor.init ( red: 112.0/255.0, green: 172.0/255.0, blue: 221.0/255.0, alpha: 1 ).cgColor]
        return layer
    }

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedRoutine?.count {
            return count
        }
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "routineCell", for: indexPath) as! RoutineCollectionViewCell
        cell.layer.cornerRadius = 10
        //cell.layer.insertSublayer(gradient(frame: cell.bounds), at:0)
        let routine = fetchedRoutine[indexPath.row]
        cell.routineName.text = routine.routinetitle
        //cell.routineButton.tag = indexPath.row
        //cell.routineButton.isOn = routine.routineButton
        
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let cell = routineCollectionView.dequeueReusableCell(withReuseIdentifier: "routineCell", for: indexPath) as! RoutineCollectionViewCell

        
    }
  /*  @IBAction func switchTapped(_ sender: UISwitch) {
        routineCollectionView.reloadData()
        let realm = try? Realm()
        if  sender.isOn == true {
            print(sender.tag)
            try? realm?.write {
                fetchedRoutine[sender.tag].routineButton = true
            }
            setFalse(tagNumber: sender.tag)
        }
    }
    func setFalse(tagNumber: Int) {
        let realm = try? Realm()
        for i in 0..<fetchedRoutine.count {
            if i != tagNumber {
                try? realm?.write {
                    fetchedRoutine[i].routineButton = false
                    }
            }
        }
    }*/

    func configurationTextField(textField: UITextField!)
    {
        textField.placeholder = "Routine 이름을 입력하세요"
        routineNameFromTextField = textField
    }


    @IBAction func addNewRoutine(_ sender: Any) {
        let realm = try? Realm()
        var newRoutine:Routine!
        //var newTaskList:List<Task>!
        newRoutine = Routine()
        let alert = UIAlertController(title: "Routine", message:"Routine 이름을 입력해주세요" , preferredStyle: .alert)
        alert.addTextField(configurationHandler: configurationTextField)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{(action:UIAlertAction!) in
            if let name = self.routineNameFromTextField.text {
                let trimName = name.trimmingCharacters(in:.whitespaces)
                if trimName == "" {
                    let alertTitle = UIAlertController(title: "Routine", message:"Routine 이름을 입력해주세요" , preferredStyle: .alert)
                    alertTitle.addAction(doneAction)
                    self.present(alertTitle, animated: true, completion: nil)
                    
                } else{
                    
                    try? realm?.write {
                        //newRoutine.routineid
                        newRoutine.routinetitle = name
                        newRoutine.routineButton = false
                        
                        realm?.add(newRoutine)
                }
            }
                
            }
            self.routineCollectionView.reloadData()
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        })
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler:{(action:UIAlertAction!) in
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTaskSegue" {
            if let destination = segue.destination as? TaskListViewController {
                if let task = sender as? Task {
                    
                    //destination.existingTask = task
                }
            }
        }
    }
    
    
}


