

import UIKit
import RealmSwift
class AddTaskViewController: UIViewController {
    var didAddHandler:((Taskmodel)-> Void)?
   
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleTextField.becomeFirstResponder()
        
    }
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.titleTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)

        
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
 
    func inputTaskData()//->Object
    {
  
    }
    
    @IBAction func taskSaved(_ sender: Any) {
        guard let title = self.titleTextField.text else {
            return
        }
        self.titleTextField.resignFirstResponder()
        let newTask = Taskmodel(tasktitle: title, starttime: startTimeTextField.text!, endtime: endTimeTextField.text!)
        self.didAddHandler?(newTask)
        self.dismiss(animated: true, completion: nil)
 
    }
    
    

    }
    



