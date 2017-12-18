

import UIKit
import RealmSwift
class AddTaskViewController: UIViewController {
    var existingTask:Task!
    let dateFormatter = DateFormatter()
    var timeTextField :UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    var timeDatePicker = UIDatePicker()
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    var endIntegerValue = 0
    var startIntegerValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()        
        setButton()
        startTimeTextField.text = "시작시간"
        endTimeTextField.text = "종료시간"
        startTimeTextField.isUserInteractionEnabled = true
        startTimeTextField.clearsOnBeginEditing = true
        endTimeTextField.isUserInteractionEnabled = true
        endTimeTextField.clearsOnBeginEditing = true
        if let passedtask = existingTask {
            titleTextField.text = passedtask.tasktitle
            startTimeTextField.text = passedtask.starttime
            endTimeTextField.text = passedtask.endtime
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.titleTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)

        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func setButton() {
        doneButton.layer.borderColor = UIColor.black.cgColor
        doneButton.layer.borderWidth = 1.0
    }

    
    @IBAction func setStartTime(_ sender: Any) {
        timeTextField = startTimeTextField
        createDatePicker()
        
    }
    @IBAction func setEndTime(_ sender: Any) {
        timeTextField = endTimeTextField
        createDatePicker()

    }

    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneToolbarButtonPressed))
        toolBar.setItems([doneButton], animated: false)
        timeDatePicker.datePickerMode = .time
        timeTextField.inputView = timeDatePicker
        timeTextField.inputAccessoryView = toolBar
    }
    @objc func doneToolbarButtonPressed(sender: UIBarButtonItem) {
        dateFormatter.timeStyle = .short
        timeTextField.text = dateFormatter.string(from: timeDatePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func taskSaved(_ sender: Any) {
        //var taskData = inputTaskData()
        var newTask:Task!
        if existingTask == nil {
            newTask = Task()
            let trimName =  titleTextField.text?.trimmingCharacters(in:.whitespaces)
            if let name = trimName {
                if name == "" {
                    let alertTitle = UIAlertController(title: "Task", message:"Task 이름을 입력해주세요" , preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertTitle.addAction(doneAction)
                    self.present(alertTitle, animated: true, completion: nil)
                } else {
                    newTask.tasktitle = name
                }
                
            }
            if let startTime = startTimeTextField.text {
                if startTime != "시작시간" {
                    if startTime != ""{
                        
                        newTask.starttime = startTime
                        var splitStartTime = startTimeTextField.text?.characters.split(separator: " ").map{String($0)}
                        var startTimeArray = splitStartTime![0].characters.split(separator:":").map{String($0)}
                        if(splitStartTime![1]=="PM") {
                            startIntegerValue = (Int(startTimeArray[0])!+12)*60 + Int(startTimeArray[1])!
                            newTask.integerStime = startIntegerValue
                        } else if(splitStartTime![1]=="AM"){
                            startIntegerValue = Int(startTimeArray[0])!*60 + Int(startTimeArray[1])!
                            newTask.integerStime = startIntegerValue
                            
                        }
                } else {}
            } else {}
            }
            
            
            if let endTime = endTimeTextField.text {
                if endTime != "종료시간" {
                    if endTime != ""{
                        newTask.endtime = endTime
                        var splitEndTime = endTime.characters.split(separator: " ").map{String($0)}
                        var endTimeArray = splitEndTime[0].characters.split(separator:":").map{String($0)}
                    
                        if(splitEndTime[1]=="PM") {
                            endIntegerValue = (Int(endTimeArray[0])!+12)*60 + Int(endTimeArray[1])!
                            newTask.integerEtime = endIntegerValue
                        } else if(splitEndTime[1]=="AM"){
                            endIntegerValue = Int(endTimeArray[0])!*60 + Int(endTimeArray[1])!
                            newTask.integerEtime = endIntegerValue
                        }
                    
                        var timeInterval = endIntegerValue-startIntegerValue
                        if(timeInterval<0) {
                            timeInterval = startIntegerValue - endIntegerValue
                            newTask.timeinterval = timeInterval
                        } else {
                            newTask.timeinterval = timeInterval
                        }
                } else {
                        //Todo: 종료시간을 입력해 주세여
                    }
                
                } else {
                    //Todo: 종료시간을 입력해 주세여
                }
            }
            let realm = try? Realm()
            try? realm?.write {
                realm?.add(newTask)

            }
            print(Realm.Configuration.defaultConfiguration.fileURL!)

        }else {
            newTask = existingTask
            let trimName =  titleTextField.text?.trimmingCharacters(in:.whitespaces)
            if let name = trimName {
                if name == "" {
                    let alertTitle = UIAlertController(title: "Task", message:"Task 이름을 입력해주세요" , preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertTitle.addAction(doneAction)
                    self.present(alertTitle, animated: true, completion: nil)
                } else {
                    newTask.tasktitle = name
                }
                
            }
            let realm = try? Realm()
            try? realm?.write {
           
             
                if let startTime = startTimeTextField.text {
                    if startTime != "시작시간" {
                        if startTime != ""{
                            newTask.starttime = startTime
                            print("******\(newTask.starttime)")
                            var splitStartTime = startTimeTextField.text?.characters.split(separator: " ").map{String($0)}
                            var startTimeArray = splitStartTime![0].characters.split(separator:":").map{String($0)}
                            if(splitStartTime![1]=="PM") {
                                startIntegerValue = (Int(startTimeArray[0])!+12)*60 + Int(startTimeArray[1])!
                                newTask.integerStime = startIntegerValue
                            } else if(splitStartTime![1]=="AM"){
                                startIntegerValue = Int(startTimeArray[0])!*60 + Int(startTimeArray[1])!
                                newTask.integerStime = startIntegerValue
                                
                            }
                        } else {}
                    } else {}
                }
                if let endTime = endTimeTextField.text {
                    if endTime != "종료시간" {
                        if endTime != ""{
                            newTask.endtime = endTime
                            var splitEndTime = endTime.characters.split(separator: " ").map{String($0)}
                            var endTimeArray = splitEndTime[0].characters.split(separator:":").map{String($0)}
                            
                            if(splitEndTime[1]=="PM") {
                                endIntegerValue = (Int(endTimeArray[0])!+12)*60 + Int(endTimeArray[1])!
                                newTask.integerEtime = endIntegerValue
                            } else if(splitEndTime[1]=="AM"){
                                endIntegerValue = Int(endTimeArray[0])!*60 + Int(endTimeArray[1])!
                                newTask.integerEtime = endIntegerValue
                            }
                            
                            var timeInterval = endIntegerValue-startIntegerValue
                            if(timeInterval<0) {
                                timeInterval = startIntegerValue - endIntegerValue
                                newTask.timeinterval = timeInterval
                            } else {
                                newTask.timeinterval = timeInterval
                            }
                        } else {
                            //Todo: 종료시간을 입력해 주세여
                        }
                    } else {
                        //Todo: 종료시간을 입력해 주세여
                    }
            }
        }
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
        }
        navigationController?.popViewController(animated: true)
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    }
    



