

import UIKit
import RealmSwift
class AddTaskViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    var timeTextField :UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    var timeDatePicker = UIDatePicker()
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setDoneButton()
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
    
    func setDoneButton() {
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
 
    func inputTaskData()->Object
    {
        var startIntegerValue = 0
        var endIntegerValue = 0
        let task=Task()
        task.tasktitle = titleTextField.text!
        task.starttime = startTimeTextField.text!
        task.endtime = endTimeTextField.text!
     
        
        
        var splitStartTime = startTimeTextField.text?.characters.split(separator: " ").map{String($0)}
        var splitEndTime = endTimeTextField.text?.characters.split(separator: " ").map{String($0)}
        
        var startTimeArray = splitStartTime![0].characters.split(separator:":").map{String($0)}
        var endTimeArray = splitEndTime![0].characters.split(separator:":").map{String($0)}
        
        if(splitStartTime![1]=="PM") {
            startIntegerValue = (Int(startTimeArray[0])!+12)*60 + Int(startTimeArray[1])!
            task.integerStime = startIntegerValue
            
        }else if(splitStartTime![1]=="AM"){
            startIntegerValue = Int(startTimeArray[0])!*60 + Int(startTimeArray[1])!
            task.integerStime = startIntegerValue
        }
        
        if(splitEndTime![1]=="PM") {
            endIntegerValue = (Int(endTimeArray[0])!+12)*60 + Int(endTimeArray[1])!
            task.integerEtime = endIntegerValue
        }else if(splitEndTime![1]=="AM"){
            endIntegerValue = Int(endTimeArray[0])!*60 + Int(endTimeArray[1])!
            task.integerEtime = endIntegerValue
        }
       
        var timeInterval = endIntegerValue-startIntegerValue
        if(timeInterval<0) {
            timeInterval = startIntegerValue - endIntegerValue
            task.timeinterval = timeInterval
        }
        else {
            task.timeinterval = timeInterval
        }
        return task
    }
    
    @IBAction func taskSaved(_ sender: Any) {
        var taskData = inputTaskData()
        let realm = try?Realm()
        try? realm?.beginWrite()
        try? realm?.add(taskData)
        try? realm?.commitWrite()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        titleTextField.text = ""
        startTimeTextField.text = ""
        endTimeTextField.text = ""
 
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let ad = UIApplication.shared.delegate as? AppDelegate
        //let setCount = ad?.taskCount
        
        print(ad?.taskdata)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("addviewadd")
        
    }
    
    }
    



