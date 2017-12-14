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

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
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
        let routine = fetchedRoutine[indexPath.row]
        cell.routineName.text = routine.routinetitle
        return cell
    }
    func configurationTextField(textField: UITextField!)
    {
        textField.placeholder = "Enter an item"
        routineNameFromTextField = textField
    }


    @IBAction func addNewRoutine(_ sender: Any) {
        let realm = try? Realm()
        var newRoutine:Routine!
        var newTaskList:List<Task>!
        newRoutine = Routine()
        //newTaskList = List<Task>
        let alert = UIAlertController(title: "Routine", message:"Routine 이름을 입력해주세요" , preferredStyle: .alert)
        alert.addTextField(configurationHandler: configurationTextField)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{(action:UIAlertAction!) in
            try? realm?.write {
                if let name = self.routineNameFromTextField.text {
                    newRoutine.routinetitle = name
                }
                //newRoutine.task = newTaskList

                realm?.add(newRoutine)
                
            }
            self.routineCollectionView.reloadData()
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        })
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler:{(action:UIAlertAction!) in
        })
        //let routineTextField = UI
       // let textField = text
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    
}
