//
//  SessionSummaryViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 17/05/2024.
//

import SwiftUI

@Observable
class SessionSummaryViewModel {
    var session: StudySession
    
    private var series: StudySeries? {
        session.parentSeries
    }
    
    var subject: String {
        series?.subject ?? "Unknown"
    }
    var color: Color {
        Color.spColor(series?.color)
    }
    
    var notes: String {
        series?.notes ?? ""
    }
    
    var sessionInfoText: String {
        let sessions = series?.sessions.sorted(by: { $0.date < $1.date }) ?? []
        if let index = sessions.firstIndex(of: session) {
            return "Session \(index + 1) of \(sessions.count)"
        }
        return "Session ? of \(sessions.count)"
    }
    
    init(session: StudySession) {
        self.session = session
    }
}
