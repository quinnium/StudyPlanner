//
//  StudyPlannerApp.swift
//  StudyPlanner
//
//  Created by Quinn on 23/02/2024.
//

import SwiftUI
import SwiftData

@main
struct StudyPlannerApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([StudySeries.self, StudySession.self])
        let config = ModelConfiguration(for: StudySeries.self, StudySession.self, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: config)
            return container
        } catch {
            fatalError("Failed to load model container")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
//            StudySeriesView(modelContext: container.mainContext, studySeries: nil)
//            CalendarView(modelContext: container.mainContext, date: Date())
            CalendarPageView()
    
        }
//        .modelContainer(for: StudySeries.self)
//                .modelContainer(for: [StudySeries.self, StudySession.self])
    }
}
