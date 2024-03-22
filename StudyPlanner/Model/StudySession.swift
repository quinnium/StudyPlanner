//
//  StudySession.swift
//  StudyPlanner
//
//  Created by Quinn on 05/03/2024.
//

import Foundation
import SwiftData

@Model
final class StudySession {
    
    var date: Date
    var parentSeries: StudySeries?
    
    init(date: Date, parentSeries: StudySeries? = nil) {
        self.date = date
        self.parentSeries = parentSeries
    }
}
