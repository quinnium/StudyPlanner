//
//  CalendarViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 26/05/2024.
//

import Foundation

@Observable
class CalendarViewModel {
    
    var dateWrapper: DateWrapper
    private var allSessions: [StudySession]
    var isShowingYearMonthPicker: Bool = false
    var tabViewSelection: Int = 1
    private var prevMonthDate: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .month, value: -1, to: dateWrapper.monthDate) ?? dateWrapper.monthDate
    }
    private var nextMonthDate: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .month, value: 1, to: dateWrapper.monthDate) ?? dateWrapper.monthDate
    }
    var monthAndYearText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: dateWrapper.monthDate)
    }

    // ViewModel for Subview
    var yearMonthPickerViewModel: YearMonthPickerViewModel {
        YearMonthPickerViewModel(dateWrapper: dateWrapper)
    }
    
    var currentCalendarMonthViewModel: CalendarMonthViewModel {
        CalendarMonthViewModel(dateWrapper: dateWrapper, allSessions: allSessions, monthDate: dateWrapper.monthDate)
    }
    var previousCalendarMonthViewModel: CalendarMonthViewModel {
        CalendarMonthViewModel(dateWrapper: dateWrapper, allSessions: allSessions, monthDate: prevMonthDate)
    }
    var nextCalendarMonthViewModel: CalendarMonthViewModel {
        CalendarMonthViewModel(dateWrapper: dateWrapper, allSessions: allSessions, monthDate: nextMonthDate)
    }
    
    init(dateWrapper: DateWrapper, allSessions: [StudySession]) {
        self.dateWrapper = dateWrapper
        self.allSessions = allSessions
    }

    func reOrderAfterMonthChange() {
        if tabViewSelection == 0 {
            dateWrapper.monthDate = prevMonthDate
        } else if tabViewSelection == 2 {
            dateWrapper.monthDate = nextMonthDate
        }
        tabViewSelection = 1
    }
}
