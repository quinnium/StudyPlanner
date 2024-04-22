//
//  CalendarViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 09/04/2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class CalendarPageViewModel {
    
    // Sub Class to ensure wrapped to pass dates as reference types to subviews
    @Observable
    class DateWrapper {
        var dateSelected: Date
        var monthDate: Date
        init(dateSelected: Date, monthDate: Date) {
            self.dateSelected = dateSelected
            self.monthDate = monthDate
        }
    }
    
    var dateWrapper = DateWrapper(dateSelected: .now, monthDate: .now.startOfCalendarMonth)
    var selectedStudySeries: StudySeries? = nil
    var isShowingAddNewStudySheet: Bool = false
    var yearMonthSelectorDisplayed: Bool = false
    private let calendar = Calendar.autoupdatingCurrent
    
    var monthAndYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: dateWrapper.monthDate)
    }
    
    // View Models for subviews
    var yearMonthPickerViewModel: YearMonthPickerViewModel {
        YearMonthPickerViewModel(dateWrapper: dateWrapper)
    }
    
    var calendarMonthViewModel: CalendarMonthDatesViewModel {
        CalendarMonthDatesViewModel(dateWrapper: dateWrapper)
    }
    
    var sessionsListViewModel: SessionsListViewModel {
        SessionsListViewModel(fromDate: dateWrapper.dateSelected, toDate: dateWrapper.dateSelected) { studySeries in
            self.selectedStudySeries = studySeries
        }
    }
    
    init() {
        selectTodaysDate()
    }
    
    func goToToday() {
        selectTodaysDate()
        dateWrapper.monthDate = Date().startOfCalendarMonth
    }
    
    func prevMonth() {
        dateWrapper.monthDate = calendar.date(byAdding: .month, value: -1, to: dateWrapper.monthDate) ?? dateWrapper.monthDate
    }
    
    func nextMonth() {
        dateWrapper.monthDate = calendar.date(byAdding: .month, value: +1, to: dateWrapper.monthDate) ?? dateWrapper.monthDate
    }
    
    func selectTodaysDate() {
        let components = calendar.dateComponents([.year,.month,.day], from: Date())
        dateWrapper.dateSelected = calendar.date(from: components) ?? Date()
    }
}
