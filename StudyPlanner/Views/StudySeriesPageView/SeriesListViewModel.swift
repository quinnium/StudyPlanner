//
//  SeriesListViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 12/05/2024.
//

import Foundation

@Observable
final class SeriesListViewModel {
    
    private var modelDataSource: ModelDataSource?
    var uncompletedSeries: [StudySeries] = []
    var completedSeries: [StudySeries] = []
    
    var selectedSeriesForEditing: StudySeries? = nil

    private let calendar = Calendar.autoupdatingCurrent
    
    // ViewModels for sub view
    var studySeriesViewModel: StudySeriesViewModel {
        StudySeriesViewModel(studySeries: selectedSeriesForEditing)
    }
    
    init(forTesting: Bool = false) {
        Task {
            await modelDataSource = forTesting ? ModelDataSource.forTesting : ModelDataSource.shared
            DispatchQueue.main.async {
                self.fetchSeries()
            }
        }
    }
    
    func fetchSeries() {
        guard let modelDataSource else { return }
        let allSeries = modelDataSource.fetchAllObjects(objectType: StudySeries.self)
        uncompletedSeries.removeAll()
        completedSeries.removeAll()
        for series in allSeries {
            // if all study sessions are complete, add to completedSeries
            if series.sessions.allSatisfy({ $0.isCompleted }) {
                completedSeries.append(series)
            } else {
                // else add to uncompletedSessions
                uncompletedSeries.append(series)
            }
        }
        // Sort completedSessions by most recent last session
        completedSeries.sort { $0.sessions.last?.date ?? Date() < $1.sessions.last?.date ?? Date() }
        // Sort uncompletedSessions by earliest incomplete session
        uncompletedSeries.sort {
            if !$0.allSessionsCompleted == !$1.allSessionsCompleted {
                return $0.firstUncompletedSessionDate ?? Date() < $1.firstUncompletedSessionDate ?? Date()
            } else {
                return !$0.allSessionsCompleted && $1.allSessionsCompleted
            }
        }
    }
    
}
