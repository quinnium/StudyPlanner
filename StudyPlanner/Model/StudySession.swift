//
//  StudySession.swift
//  StudyPlanner
//
//  Created by Quinn on 05/03/2024.
//

import Foundation
import SwiftData

@Model
final class StudySession: Equatable, Identifiable {
    
    let id: UUID = UUID()
    var date: Date
    var parentSeries: StudySeries?
    var isCompleted: Bool
    
    init(date: Date, parentSeries: StudySeries? = nil, isCompleted: Bool = false) {
        self.date = date
        self.parentSeries = parentSeries
        self.isCompleted = isCompleted
    }
}
