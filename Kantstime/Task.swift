import Foundation
import RealmSwift

class Routine: Object {
    @objc dynamic var routinetitle = ""
    var task = List<Task>()
}

class Task: Object {
    @objc dynamic var tasktitle = ""
    @objc dynamic var starttime=""
    @objc dynamic var endtime=""
    @objc dynamic var integerStime=0
    @objc dynamic var integerEtime=0
    @objc dynamic var timeinterval=0
    
}


