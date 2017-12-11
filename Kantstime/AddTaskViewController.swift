

import UIKit
import RealmSwift
class AddTaskViewController: UIViewController {
    
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
    }

    @IBAction func homeButtonClicked(_ sender: Any) {
        let mainViewController = ViewController()
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func setButton() {
        doneButton.layer.borderColor = UIColor.black.cgColor
        doneButton.layer.borderWidth = 1.0
        
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.layer.borderWidth = 1.0
        
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
 
   /* func inputTaskData()->Object
    {
        let task=Task()
        task.tasktitle = titleTextField.text!
        task.starttime = startTimeTextField.text!
        task.endtime = endTimeTextField.text!
     
        
        
     
     
        return task
    }*/
    
    @IBAction func taskSaved(_ sender: Any) {
        //var taskData = inputTaskData()
        let newTask:Task!
        newTask = Task()
        if let name = titleTextField.text {
            newTask.tasktitle = name
        } else {
            //TODO:::notification
        }
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
            } else {
                //
            }
        } else {
            
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
        navigationController?.popViewController(animated: true)
    }
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    }
    



