//
//  Date.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 31/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import Foundation
extension Date {
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let stringMonth = dateFormatter.string(from: self)
        return stringMonth
    }
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let stringDay = dateFormatter.string(from: self)
        return stringDay
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        let stringTime = dateFormatter.string(from: self)
        return stringTime
    }
    
}
