//
//  SeriesListViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 12/05/2024.
//

import Foundation

@Observable
final class SeriesListViewModel {
    
    var modelDataSource: ModelDataSource?
    
    var allSeries: [StudySeries] = []
    
    var selectedSeriesForEditing: StudySeries? = nil
    
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
        allSeries = modelDataSource.fetchAllObjects(objectType: StudySeries.self)
    }
    
}
