//
//  SeriesSummaryViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 11/05/2024.
//

import SwiftUI

@Observable
class SeriesSummaryViewModel {
    
    let series: StudySeries
    // TODO: put these calcualted properties into the model
    var completedSessions: Int {
        series.sessions.filter { $0.isCompleted }.count
    }
    var overdueSessions: [StudySession] {
        series.sessions.filter { !$0.isCompleted && $0.date < Calendar.autoupdatingCurrent.startOfDay(for: .now) }
    }
    var allSessionsCompleted: Bool {
        completedSessions == series.sessions.count
    }
    var upcomingSessions: [StudySession] {
        series.sessions.filter { !$0.isCompleted && $0.date >= Calendar.autoupdatingCurrent.startOfDay(for: .now) }
    }
    var color: Color {
        Color.spColor(series.color)
    }
    let calendar = Calendar.autoupdatingCurrent
    
    var _nextSessionText: String {
        // If all study sessions have already been 'completed'
        if completedSessions == series.sessions.count {
            return "All study sessions completed"
        } else {
            let orderedSessions = series.sessions.sorted { $0.date < $1.date }
            let incompleteSessions = orderedSessions.filter { $0.isCompleted == false }
            let overdueStudies = incompleteSessions.filter { $0.date < calendar.startOfDay(for: .now) }
            // if any incomplete sessions have a date before today's date
            if overdueStudies.count > 0 {
                return "\(overdueStudies.count) study sessions overdue!!"
            }
            // simply list the date of the next study session
            else {
                let nextStudySession = incompleteSessions.first { $0.date >= calendar.startOfDay(for: .now) }
                return "Next study session: \(nextStudySession?.date.formatted(date: .abbreviated, time: .omitted) ?? "unknown")"
            }
        }
    }
    
    var overdueSessionText: String {
        let multiple = overdueSessions.count > 1
        return "⚠️ \(overdueSessions.count) Study \(multiple ? "sessions" : "session") overdue (from \(series.firstUncompletedSessionDate?.formatted(date: .abbreviated, time: .omitted) ?? ""))"
    }
    
    var upcomingSessionsText: String {
        if let date = series.nextUncompletedSessionDate {
            return "Next study session \(date.formatted(date: .abbreviated, time: .omitted))"
        } else {
            return ""
        }
    }
    
    init(series: StudySeries) {
        self.series = series
    }
}
