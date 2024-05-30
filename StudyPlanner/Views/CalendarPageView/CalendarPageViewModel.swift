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

    private var dateWrapper: DateWrapper
    private var modelDataSource: ModelDataSource?
    private var allSessions: [StudySession] = []
    private var sessionsForDateSelected: [StudySession] {
        allSessions.filter { $0.date == dateWrapper.dateSelected }
    }
    var isShowingAddNewSeriesSheet: Bool = false

    // View Models for subviews
    var calendarViewModel: CalendarViewModel {
        CalendarViewModel(dateWrapper: dateWrapper, allSessions: allSessions)
    }
    var sessionsListViewModel: DaySessionsListViewModel {
        DaySessionsListViewModel(sessions: sessionsForDateSelected)
    }
    var newStudySeriesViewModel: StudySeriesViewModel {
        StudySeriesViewModel(studySeries: nil, selectedDate: dateWrapper.dateSelected)
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
        allSessions = modelDataSource.fetchAllObjects(objectType: StudySession.self)
    }
}
