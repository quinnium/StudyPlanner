//
//  SPDay.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import Foundation

struct SPDay: Hashable {
    
    let name: String
    let shortname: String
    let veryshortName: String
    let weekday: Int
}


enum SPDays {
    static let sunday       = SPDay(name: "Sunday", shortname: "Sun", veryshortName: "S", weekday: 1)
    static let monday       = SPDay(name: "Monday", shortname: "Mon", veryshortName: "M", weekday: 2)
    static let tuesday      = SPDay(name: "Tuesday", shortname: "Tue", veryshortName: "T", weekday: 3)
    static let wednesday    = SPDay(name: "Wednesday", shortname: "Wed", veryshortName: "W", weekday: 4)
    static let thursday     = SPDay(name: "Thursday", shortname: "Thu", veryshortName: "T", weekday: 5)
    static let friday       = SPDay(name: "Friday", shortname: "Fri", veryshortName: "F", weekday: 6)
    static let saturday     = SPDay(name: "Saturday", shortname: "Sat", veryshortName: "S", weekday: 7)
    
    static let allDays      = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
    static let firstDayInt  = allDays[0].weekday
}
