

import UIKit
import RealmSwift
class AddTaskViewController: UIViewController {
    var routineName:String!
    var existingTask:Task!
    var passedRoutineName:String!
    var fetchedTask:List<Task>!
    let dateFormatter = DateFormatter()
    var timeTextField :UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    var timeDatePicker = UIDatePicker()
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var taskList:[Task]=[Task]()
    var endIntegerValue = 0
    var startIntegerValue = 0
    var timeCheckDic:[Int:String]!=[Int:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
            startTimeTextField.isEnabled = false
            endTimeTextField.isEnabled = false
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneToolbarButtonPressed))
        toolBar.setItems([doneButton], animated: false)
        timeDatePicker.datePickerMode = .time
        timeDatePicker.minuteInterval = 30
        dateFormatter.dateFormat = "hh:mm a"
        timeDatePicker.date = dateFormatter.date(from: "06:30 AM")!
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
        let realm = try? Realm()
        var newTask:Task!
        var nilTime:Bool!
        nilTime = false
        if existingTask == nil {
            newTask = Task()
            routineName = passedRoutineName
            fetchedTask = realm?.objects(Routine.self).filter("routinetitle = '\(passedRoutineName!)'").first?.task

            let trimName =  titleTextField.text?.trimmingCharacters(in:.whitespaces)
            if let name = trimName {
                if name == "" {
                    let alertTitle = UIAlertController(title: "Task", message:"Task 이름을 입력해주세요" , preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertTitle.addAction(doneAction)
                    self.present(alertTitle, animated: true, completion: nil)
                } else {
                    newTask.routinetitle = routineName
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
                            if startTimeArray[0] == "12" {
                                startIntegerValue = (Int(startTimeArray[0])!)*60 + Int(startTimeArray[1])!
                            }else {
                                startIntegerValue = (Int(startTimeArray[0])!+12)*60 + Int(startTimeArray[1])!
                            }
                            newTask.integerStime = startIntegerValue
                            
                        } else if(splitStartTime![1]=="AM"){
                            if startTimeArray[0] == "12" {
                                startTimeArray[0] = "0"
                            }
                            startIntegerValue = Int(startTimeArray[0])!*60 + Int(startTimeArray[1])!
                            newTask.integerStime = startIntegerValue
                            
                        }
                    }else {
                        //alert
                        nilTime = true
                    }
                }else {
                        //alert
                        nilTime = true
                }
            }
            
            if let endTime = endTimeTextField.text {
                if endTime != "종료시간" {
                    if endTime != ""{
                        newTask.endtime = endTime
                        var splitEndTime = endTime.characters.split(separator: " ").map{String($0)}
                        var endTimeArray = splitEndTime[0].characters.split(separator:":").map{String($0)}
                        
                        if(splitEndTime[1]=="PM") {
                            if endTimeArray[0] == "12" {
                                endIntegerValue = (Int(endTimeArray[0])!)*60 + Int(endTimeArray[1])!
                            }else {
                                endIntegerValue = (Int(endTimeArray[0])!+12)*60 + Int(endTimeArray[1])!
                            }
                            newTask.integerEtime = endIntegerValue-1
                        } else if(splitEndTime[1]=="AM"){
                            if endTimeArray[0] == "12" && endTimeArray[1] == "00" {
                                endTimeArray[0] = "24"
                            
                            } else if endTimeArray[0] == "12" && endTimeArray[1] == "30" {
                                endTimeArray[0] = "00"
                                endTimeArray[1] = "30"
                            }
                            
                            endIntegerValue = Int(endTimeArray[0])!*60 + Int(endTimeArray[1])!
                            newTask.integerEtime = endIntegerValue-1
                            print("????\(newTask.integerStime)")
                            print("????\(newTask.integerEtime)")
                            
                        }
                        var timeInterval = endIntegerValue-startIntegerValue
                        if(newTask.integerEtime<=720&&timeInterval<0) {
                            nilTime = true
                            let alert = UIAlertController(title: "다시 입력해주세요", message: "\n Endtime은 12시까지 입니다.", preferredStyle: .alert)
                            let doneAction = UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction) in
                            })
                            alert.addAction(doneAction)
                            self.present(alert, animated: true, completion: nil)
                            
                        } else {
                            newTask.timeinterval = timeInterval
                        }
                    }else {
                        nilTime = true
                    }
                } else {
                    nilTime = true
                }
            }
            var timeOverlap = false
            var overlapTask:Task!
        
            for i in 0..<fetchedTask.count {
                var startTime = fetchedTask[i].integerStime
                var endTime = fetchedTask[i].integerEtime
                var checkStartTime = newTask.integerStime
                var checkEndTime = newTask.integerEtime
                if(checkStartTime > startTime && checkEndTime < endTime)
                {
                    timeOverlap = true
                    overlapTask = fetchedTask[i]
                }else if(checkStartTime > startTime && checkStartTime < endTime){
                    timeOverlap = true
                    overlapTask = fetchedTask[i]
                }else if(checkEndTime > startTime && checkEndTime < endTime){
                    timeOverlap = true
                    overlapTask = fetchedTask[i]
                }else if(checkStartTime==startTime || checkEndTime==endTime){
                    timeOverlap = true
                    overlapTask = fetchedTask[i]
                }else if(startTime > checkStartTime && endTime < checkEndTime){
                    timeOverlap = true
                    overlapTask = fetchedTask[i]
                }
            }
             if timeOverlap == false && nilTime == false {
                try? realm?.write {
                    fetchedTask.append(newTask)
                }
                
                navigationController?.popViewController(animated: true)

            } else {
                if timeOverlap == true {
                    let alert = UIAlertController(title: "다시 입력해주세요", message: "\(overlapTask.tasktitle)(\(overlapTask.starttime) ~ \(overlapTask.endtime))와 시간이 겹칩니다.", preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction) in
                    })
                    alert.addAction(doneAction)
                    self.present(alert, animated: true, completion: nil)
                }
                if nilTime == true {
                    let alert = UIAlertController(title: "입력해주세요", message: "\n시간을 선택해주세요", preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction) in
                        
                    })
                    alert.addAction(doneAction)
                    self.present(alert, animated: true, completion: nil)                }
                
            }
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
        }else {
            newTask = existingTask
            routineName = existingTask.routinetitle
            try? realm?.write {
                
            let trimName =  titleTextField?.text?.trimmingCharacters(in:.whitespaces)
            if let name = trimName {
                if name == "" {
                    let alertTitle = UIAlertController(title: "Task", message:"Task 이름을 입력해주세요" , preferredStyle: .alert)
                    let doneAction = UIAlertAction(title: "Done", style: .default, handler: nil)
                    alertTitle.addAction(doneAction)
                    self.present(alertTitle, animated: true, completion: nil)
                } else {
                    newTask.routinetitle = routineName
                    newTask.tasktitle = name
                }
            }
                navigationController?.popViewController(animated: true)      
        }
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
}



