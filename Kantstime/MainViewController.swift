//
//  MainViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 31/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class MainViewController: UIViewController {
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var routineTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        month.text = date.getMonthName()
        day.text = date.getDay()
        time.text = date.getTime()
    }
}

