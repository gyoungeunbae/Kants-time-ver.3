//
//  RoutineCollectionViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 14/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift

class RoutineCollectionViewController: ViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
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
        let cellRadius = cell.layer.frame.height/2
        cell.layer.cornerRadius = cellRadius
        let routine = fetchedRoutine[indexPath.row]
        let buttonValue = routine.routineButton
        cell.routineButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.routineButton.isOn = routine.routineButton
      
       if buttonValue == true {
             var colors = [UIColor]()
             colors.append(UIColor.init(red: 0.0/255.0, green: 219.0/255.0, blue: 222.0/255.0, alpha: 1))
             colors.append(UIColor.init(red: 252.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1))
             cell.routineColor.applyGradient(colors: colors)
             cell.routineName.textColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.7)
             cell.routineButton.thumbTintColor = UIColor.white

        }else {
            var colors = [UIColor]()
            colors.append(UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1))
            colors.append(UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1))
            cell.routineColor.applyGradient(colors: colors)
            //cell.routineName.textColor = UIColor.gray
            cell.routineColor.applyGradient(colors: colors)
        
        }
        cell.routineName.text = routine.routinetitle
        cell.routineButton.tag = indexPath.row
        
  
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        let fetched = fetchedRoutine[indexPath.row]
        let realm = try? Realm()
        try? realm?.write {
            realm?.delete(fetched)
            routineCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let routine = fetchedRoutine[indexPath.row]
        performSegue(withIdentifier: "goTaskSegue", sender: routine)

    }
   
    @IBAction func switchTapped(_ sender: UISwitch) {
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
    }

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
                if let routine = sender as? Routine {
                    destination.existingRoutine = routine
                    
                }
            }
        }
    } 
}
/*
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x:0,y:0.5)
        gradient.endPoint = CGPoint(x:1,y:0.8)
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
}

*/
