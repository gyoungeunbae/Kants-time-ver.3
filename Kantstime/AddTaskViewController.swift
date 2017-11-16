

import UIKit

class AddTaskViewController: UIViewController {
    let dateFormatter = DateFormatter()
    var timeTextField :UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    var timeDatePicker = UIDatePicker()
    @IBOutlet weak var doneButton: UIButton!
    
   
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
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: true);
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
        var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: false)
        timeDatePicker.datePickerMode = .time
        timeTextField.inputView = timeDatePicker
        timeTextField.inputAccessoryView = toolBar
    }
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        dateFormatter.timeStyle = .short
        timeTextField.text = dateFormatter.string(from: timeDatePicker.date)
        self.view.endEditing(true)
    }
 
    
    
    
    
}

