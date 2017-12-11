struct Taskmodel {
    var tasktitle = ""
    var starttime=""
    var endtime=""
    var integerStime=0
    var integerEtime=0
    var timeinterval=0
    
    init(tasktitle:String,starttime:String,endtime:String) {
            self.tasktitle = tasktitle
            self.starttime = starttime
            self.endtime = endtime
    }
}
