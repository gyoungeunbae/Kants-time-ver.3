import Foundation
import RealmSwift

class Routine: Object {
    @objc dynamic var routinetitle=""
    @objc dynamic var routineButton=false
    var task = List<Task>()
    override static func primaryKey() -> String? {
        return "routinetitle"
    }
}



