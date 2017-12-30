//
//  Task.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 31/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import Foundation
import RealmSwift
class Task: Object {
    @objc dynamic var routinetitle = ""
    @objc dynamic var tasktitle = ""
    @objc dynamic var starttime=""
    @objc dynamic var endtime=""
    @objc dynamic var integerStime=0
    @objc dynamic var integerEtime=0
    @objc dynamic var timeinterval=0
}
