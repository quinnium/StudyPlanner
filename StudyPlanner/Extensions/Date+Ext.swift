//
//  Date+Ext.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import Foundation

extension Date {
    
    func isSameCalendarDate(as dateToCompare: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        let componantsSelf = calendar.dateComponents([.year,.month,.day], from: self)
        let componantsDateToCompare = calendar.dateComponents([.year,.month,.day], from: dateToCompare)
        return componantsSelf == componantsDateToCompare
    }
    
    func firstWeekDayOfMonth() -> Int {
        var components = Calendar.autoupdatingCurrent.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth = Calendar.current.date(from: components) ?? Date()
        return Calendar.current.component(.weekday, from: firstDateOfMonth)
    }
    
    func numberOfDaysInMonth() -> Int {
        let range = Calendar.autoupdatingCurrent.range(of: .day, in: .month, for: self)
        return range?.count ?? 0
    }
    
    func allDatesInMonth() -> [Date] {
        let calendar = Calendar.current
        let startDateComponents = calendar.dateComponents([.year, .month], from: self)
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
            return []
        }
        var currentDate = startDate
        var allDates: [Date] = []
        while currentDate <= endDate {
            allDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return allDates
    }
    
    var startOfCalendarMonth: Date {
        Calendar.autoupdatingCurrent.dateInterval(of: .month, for: self)!.start
    }

    var endOfCalendarMonth: Date {
        Calendar.autoupdatingCurrent.dateInterval(of: .month, for: self)!.end
    }
}
