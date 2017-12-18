//
//  RoutineCollectionViewCell.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 14/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class RoutineCollectionViewCell: UICollectionViewCell {
    var routineList: Routine!
    let realm = try? Realm()
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineButton: UISwitch!
    @IBOutlet weak var routineColor: UIView!
    
}
