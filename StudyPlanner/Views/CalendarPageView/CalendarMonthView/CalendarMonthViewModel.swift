//
//  CalendarMonthViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 08/04/2024.
//

import Foundation
import SwiftUI

@Observable
class CalendarMonthViewModel {
    
//    var dateSelected: Date
//    var monthDate: Date
    var dateWrapper: CalendarPageViewModel.DateWrapper
    var modelDataSource: ModelDataSource?
    var offsetDaysAtStartOfMonth: Int {
        // number of 'gap' days preceeding 1st of the month
        return abs(dateWrapper.monthDate.firstWeekDayOfMonth() - SPDays.firstDayInt)
    }
    var allDatesInMonth: [Date] {
        dateWrapper.monthDate.allDatesInMonth()
    }
    var sessionsForMonth: [Date: [StudySession]] = [:]
    
    private let calendar = Calendar.autoupdatingCurrent

    init(dateWrapper: CalendarPageViewModel.DateWrapper) {
        print("CalendarMonthViewModel init run")
        self.dateWrapper = dateWrapper
        Task {
            await modelDataSource = ModelDataSource.shared
            fetchSessionsForMonth()
        }
    }
    
    func fetchSessionsForMonth() {
        // Fetch sessions and filter for just those within month
        guard let modelDataSource = modelDataSource else {
            print("model datasource not yet instantiated")
            return
        }
        let sessions = modelDataSource.fetchAllObjects(objectType: StudySession.self).filter {
            $0.date >= dateWrapper.monthDate.startOfCalendarMonth && $0.date <= dateWrapper.monthDate.endOfCalendarMonth
        }
        print("modelDataSource found, fetched \(sessions.count) sessions, propagating the sessionsForMonth dict")
        // Propagae sessionsForMonth dictionary
        for session in sessions {
            let components = calendar.dateComponents([.year,.month,.day], from: session.date)
            let date = calendar.date(from: components) ?? dateWrapper.monthDate
            sessionsForMonth[date, default: []].append(session)
        }
    }
}
