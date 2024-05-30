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
    private let monthDate: Date
    private let allSessions: [StudySession]
    // TODO: can get rid of completedDict?
    var completedSessionColorsDict: [Date: Set<Color>] = [:]
    var incompletedSessionColorsDict: [Date: Set<Color>] = [:]
    
    var offsetDaysAtStartOfMonth: Int {
        // number of 'gap' days preceeding 1st of the month
        abs(monthDate.firstWeekDayOfMonth() - SPDays.firstDayInt)
    }
    
    var allDatesInMonth: [Date] {
        monthDate.allDatesInMonth()
    }

    init(dateWrapper: DateWrapper, allSessions: [StudySession], monthDate: Date) {
        self.dateWrapper = dateWrapper
        self.allSessions = allSessions
        self.monthDate = monthDate
        configureSessionColorsForMonth()
    }
    
    func configureSessionColorsForMonth() {
        // Propagate sessionColorsForMonthDates dictionary
        let monthSession = allSessions.filter {
            $0.date >= monthDate.startOfCalendarMonth &&
            $0.date <= monthDate.endOfCalendarMonth
        }
        for session in monthSession {
            if session.isCompleted {
                completedSessionColorsDict[session.date, default: []].insert(Color.spColor(session.parentSeries?.color))
            } else {
                incompletedSessionColorsDict[session.date, default: []].insert(Color.spColor(session.parentSeries?.color))
            }
        }
    }
}
