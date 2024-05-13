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

    private var modelDataSource: ModelDataSource?
    private var sessionsForMonth: [StudySession] = []
    var dateWrapper: DateWrapper
    var isShowingAddNewSeriesSheet: Bool = false
    var isShowingAllSubjects: Bool = false

    private var sessionsForDateSelected: [StudySession] {
        sessionsForMonth.filter { $0.date == dateWrapper.dateSelected }
    }

    // View Models for subviews
    var calendarHeaderViewModel: CalendarHeaderViewModel {
        CalendarHeaderViewModel(dateWrapper: dateWrapper)
    }
    var calendarMonthViewModel: CalendarMonthViewModel {
        CalendarMonthViewModel(dateWrapper: dateWrapper, sessionsForMonth: sessionsForMonth)
    }
    var sessionsListViewModel: SessionsListViewModel {
        SessionsListViewModel(sessions: sessionsForDateSelected)
    }
    var newStudySeriesViewModel: StudySeriesViewModel {
        StudySeriesViewModel(studySeries: nil, selectedDate: dateWrapper.dateSelected)
    }
    var SeriesListViewModel: SeriesListViewModel {
        StudyPlanner.SeriesListViewModel()
    }
    
    init(dateWrapper: DateWrapper, forTesting: Bool = false) {
        self.dateWrapper = dateWrapper
        Task {
            await modelDataSource = forTesting ? ModelDataSource.forTesting : ModelDataSource.shared
            DispatchQueue.main.async {
                self.fetchData()
            }
        }
    }
    
    func fetchData() {
        guard let modelDataSource else { return }
        sessionsForMonth = modelDataSource.fetchStudySessionsForDateRange(from: dateWrapper.monthDate.startOfCalendarMonth, to: dateWrapper.monthDate.endOfCalendarMonth)
    }
}
