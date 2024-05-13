//
//  SeriesSummaryViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 11/05/2024.
//

import Foundation

@Observable
class SeriesSummaryViewModel {
    
    let series: StudySeries
    var sessionsCompleted: Int {
        series.sessions.filter { $0.isCompleted }.count
    }
    
    init(series: StudySeries) {
        self.series = series
    }
}
