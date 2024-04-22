//
//  CalendarMonthViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 08/04/2024.
//

import Foundation
import SwiftUI

@Observable
final class CalendarMonthDatesViewModel {
    
    var dateWrapper: CalendarPageViewModel.DateWrapper
    private var modelDataSource: ModelDataSource?
    private let calendar = Calendar.autoupdatingCurrent
    
    var offsetDaysAtStartOfMonth: Int {
        // number of 'gap' days preceeding 1st of the month
        return abs(dateWrapper.monthDate.firstWeekDayOfMonth() - SPDays.firstDayInt)
    }
    var allDatesInMonth: [Date] {
        dateWrapper.monthDate.allDatesInMonth()
    }
    var sessionColorsForMonthDates: [Date: Set<Color>] = [:]

    init(dateWrapper: CalendarPageViewModel.DateWrapper) {
        self.dateWrapper = dateWrapper
        Task {
            await modelDataSource = ModelDataSource.shared
            DispatchQueue.main.async {
                self.fetchSessionColorsForMonth()
            }
        }
    }
    
    func fetchSessionColorsForMonth() {
        // Check modelDataSource is loaded
        guard let modelDataSource = modelDataSource else { return }
        // Fetch sessions (filter for just those within month)
        let monthSessions = modelDataSource.fetchStudySessionsForDateRange(from: dateWrapper.monthDate.startOfCalendarMonth, to: dateWrapper.monthDate.endOfCalendarMonth)
        // Propagate sessionColorsForMonthDates dictionary
        for session in monthSessions {
            let components = calendar.dateComponents([.year,.month,.day], from: session.date)
            let date = calendar.date(from: components) ?? dateWrapper.monthDate
            sessionColorsForMonthDates[date, default: []].insert(Color.from(spColor: session.parentSeries?.color))
        }
    }
}
