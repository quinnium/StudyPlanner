//
//  StudySeries.swift
//  StudyPlanner
//
//  Created by Quinn on 23/02/2024.
//

import Foundation
import SwiftData
import SwiftUI

enum SPColor: String, Codable, CaseIterable {
    case pink, orange, yellow, green, blue, purple, brown, mint, indigo
}

@Model
final class StudySeries {
    var subject: String
    var notes: String
    var color: SPColor
    @Relationship(deleteRule: .cascade)
    var sessions: [StudySession]
    
    init(subject: String, color: SPColor, notes: String, sessions: [StudySession]) {
        self.subject    = subject
        self.notes      = notes
        self.sessions   = sessions
        self.color      = color
        self.sessions   = sessions
    }
    
    var allSessionsCompleted: Bool {
        sessions.allSatisfy { $0.isCompleted }
    }
    
    var firstUncompletedSessionDate: Date? {
        var uncompletedSessions = sessions.filter { !$0.isCompleted }
        let sorted = uncompletedSessions.sorted { $0.date < $1.date }
        return sorted.first?.date
    }
    
    var nextUncompletedSessionDate: Date? {
        var uncompletedSessions = sessions.filter { !$0.isCompleted }
        let sorted = uncompletedSessions.sorted { $0.date < $1.date }
        let nextUncompletedSession = sorted.first { $0.date >= Calendar.autoupdatingCurrent.startOfDay(for: .now) }
        return nextUncompletedSession?.date
    }
}
