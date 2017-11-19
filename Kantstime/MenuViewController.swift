//
//  MenuViewController.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 10/11/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func dismissMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(" menumenu")
    }
    
}
