//
//  DaySessionsListViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 22/04/2024.
//

import Foundation

@Observable
final class DaySessionsListViewModel {

    var sessions: [StudySession] = []
    var selectedSeriesForEditing: StudySeries?
    var headerOpacity: Double = 1

    // ViewModel for subview
    var studySeriesViewModel: StudySeriesViewModel {
        StudySeriesViewModel(studySeries: selectedSeriesForEditing)
    }
    
    init(sessions: [StudySession]) {
        self.sessions = sessions
        orderSessions()
    }    
    
    func orderSessions() {
        sessions.sort {
            if !$0.isCompleted == !$1.isCompleted {
                return
                    ($0.parentSeries?.subject ?? "", $0.parentSeries?.sessions.firstIndex(of: $0) ?? 0) <
                    ($1.parentSeries?.subject ?? "", $1.parentSeries?.sessions.firstIndex(of: $1) ?? 0)
            }
            return !$0.isCompleted && $1.isCompleted
        }
        self.sessions = sessions
    }
    
    func getSessionInfoText(session: StudySession) -> String {
        guard let parentSeries = session.parentSeries else { return "" }
        let existingSessions = parentSeries.sessions.sorted { $0.date < $1.date }
        guard let index = existingSessions.firstIndex(of: session) else { return ""}
        let sessionNumber = String(index + 1)
        let totalNumber = String(parentSeries.sessions.count)
        return "Session \(sessionNumber) of \(totalNumber)"
    }
}
