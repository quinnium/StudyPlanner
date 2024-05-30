//
//  DateWrapper.swift
//  StudyPlanner
//
//  Created by Quinn on 01/05/2024.
//

import Foundation

// Class to pass dates to subviews as reference type
@Observable
class DateWrapper {
    var dateSelected: Date
    var monthDate: Date
    private let calendar = Calendar.autoupdatingCurrent
    
    init(dateSelected: Date) {
        self.dateSelected = calendar.startOfDay(for: dateSelected)
        self.monthDate = dateSelected.startOfCalendarMonth
    }
    
    func selectToday() {
        dateSelected = calendar.startOfDay(for: .now)
        monthDate = dateSelected.startOfCalendarMonth
    }
    
    func prevMonth() {
        monthDate = calendar.date(byAdding: .month, value: -1, to: monthDate) ?? monthDate
    }
    
    func nextMonth() {
        monthDate = calendar.date(byAdding: .month, value: +1, to: monthDate) ?? monthDate
    }
}
