//
//  CalendarViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable
class CalendarPageViewModel {
    
    @ObservationIgnored
    private var modelDataSource: ModelDataSource?

    var isShowingAddNewStudySheet: Bool = false
    var studySeries: [StudySeries] = []
    var selectedStudySeries: StudySeries? = nil
    
    init() {
        Task {
            modelDataSource = await ModelDataSource.shared
            DispatchQueue.main.async {
                self.fetchItems()
            }
        }
    }
    func fetchItems() {
        guard modelDataSource != nil else {
            print("no Model Data Source Found!")
            return
        }
        studySeries = modelDataSource!.fetchAllObjects(objectType: StudySeries.self)
    }
}
