//
//  Sorting.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 23/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//
import RealmSwift
import Foundation
class Sorting {
    func mergeSort( list: List<Task>)->[Task]{
        var list = Array(list)
        if list.count <= 1 {
            return list
        }
        var lList = List<Task>()
        var rList = List<Task>()
        
        let mid = list.count / 2
        for i in 0..<mid {
            lList.append(list[i])
        }
        for j in mid..<list.count {
            rList.append(list[j])

        }
        
        
        var left = mergeSort(list: lList)
        var right = mergeSort(list: rList)
        
        return merge(left: left, right: right)
    }
    func merge( left: [Task], right: [Task]) -> [Task] {
        var right = right
        var left = left
        var result = [Task]()
        while !left.isEmpty && !right.isEmpty {
            let firstLeft = dateFromString(task: left[0])
            let firstRight = dateFromString(task: right[0])
            let value = firstLeft < firstRight ? left.remove(at: 0) : right.remove(at: 0)
            result.append(value)
        }
        if !left.isEmpty {
            result += left
            
        }
        if !right.isEmpty {
            result += right
            
        }
        return result
    }
    func dateFromString(task: Task) -> Date{
        let dateform = DateFormatter()
        dateform.dateFormat = "hh:mm a"
        dateform.amSymbol = "AM"
        dateform.pmSymbol = "PM"
        var sort = Sorting()
        dateform.locale = Locale(identifier: "ko_KR")
        let date = dateform.date(from:"\(task.starttime)")
        return date!
    }
    
}
