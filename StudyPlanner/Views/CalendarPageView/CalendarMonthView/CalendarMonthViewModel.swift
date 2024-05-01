//
//  CalendarMonthViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 08/04/2024.
//

import Foundation
import SwiftUI

@Observable
final class CalendarMonthViewModel {
    
    var dateWrapper: DateWrapper
    private let sessionsForMonth: [StudySession]
    var completedSessionColorsDict: [Date: Set<Color>] = [:]
    var incompletedSessionColorsDict: [Date: Set<Color>] = [:]
    
    var offsetDaysAtStartOfMonth: Int {
        // number of 'gap' days preceeding 1st of the month
        abs(dateWrapper.monthDate.firstWeekDayOfMonth() - SPDays.firstDayInt)
    }
    
    var allDatesInMonth: [Date] {
        dateWrapper.monthDate.allDatesInMonth()
    }

    init(dateWrapper: DateWrapper, sessionsForMonth: [StudySession]) {
        self.dateWrapper = dateWrapper
        self.sessionsForMonth = sessionsForMonth
        configureSessionColorsForMonth()
    }
    
    func configureSessionColorsForMonth() {
        // Propagate sessionColorsForMonthDates dictionary
        for session in sessionsForMonth {
            if session.isCompleted {
                completedSessionColorsDict[session.date, default: []].insert(Color.from(spColor: session.parentSeries?.color))
            } else {
                incompletedSessionColorsDict[session.date, default: []].insert(Color.from(spColor: session.parentSeries?.color))
            }
        }
    }
}
