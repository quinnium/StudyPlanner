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
}
