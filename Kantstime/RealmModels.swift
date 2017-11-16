import Foundation
import RealmSwift

class Routine: Object {
    var rid = Int()
    @objc dynamic var rtitle = ""
    var task = List<Task>()
}

class Task: Object {
    @objc dynamic var tasktitle = ""
    @objc dynamic var starttime=Date()
    @objc dynamic var endtime=Date()    
    @objc dynamic var integerStime=0
    @objc dynamic var integerEtime=0
    @objc dynamic var timeinterval=0
    
}


