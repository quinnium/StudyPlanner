//
//  CalendarHeaderViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 28/04/2024.
//

import Foundation

@Observable
class CalendarHeaderViewModel {
    
    private var dateWrapper: DateWrapper
    var yearMonthSelectorDisplayed: Bool = false

    var monthAndYearText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: dateWrapper.monthDate)
    }
    
    // ViewModel for Subview
    var yearMonthPickerViewModel: YearMonthPickerViewModel {
        YearMonthPickerViewModel(dateWrapper: dateWrapper)
    }
    
    init(dateWrapper: DateWrapper) {
        self.dateWrapper = dateWrapper
    }

    func goToToday() {
        dateWrapper.selectToday()
    }
    
    func prevMonth() {
        dateWrapper.prevMonth()
    }
    
    func nextMonth() {
        dateWrapper.nextMonth()
    }
}
