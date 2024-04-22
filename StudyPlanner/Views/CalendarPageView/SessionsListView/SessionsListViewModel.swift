//
//  SessionsListViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 22/04/2024.
//

import Foundation

@Observable
final class SessionsListViewModel {
    private let fromDate: Date
    private let toDate: Date
    var sessions: [StudySession] = []
    var didSelectSeries: (StudySeries) -> Void
    
    private var modelDataSource: ModelDataSource?

    init(fromDate: Date, toDate: Date, didSelectSeries: @escaping (StudySeries) -> Void) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.didSelectSeries = didSelectSeries
        Task {
            modelDataSource = await ModelDataSource.shared
            DispatchQueue.main.async { [weak self] in
                self?.fetchSessions()
            }
        }
    }
    
    func fetchSessions() {
        // Check modelDataSource is loaded
        guard let modelDataSource = modelDataSource else { return }
        // Fetch sessions (filter for just those within month)
        sessions = modelDataSource.fetchStudySessionsForDateRange(from: fromDate, to: toDate)
    }
}
