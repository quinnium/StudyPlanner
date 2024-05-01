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
    
    let dateWrapper = DateWrapper(dateSelected: .now)
    
//    let container: ModelContainer = {
//        let schema = Schema([StudySeries.self, StudySession.self])
//        let config = ModelConfiguration(for: StudySeries.self, StudySession.self, isStoredInMemoryOnly: false)
//        do {
//            let container = try ModelContainer(for: schema, configurations: config)
//            return container
//        } catch {
//            fatalError("Failed to load model container")
//        }
//    }()
//    
    var body: some Scene {
        WindowGroup {
            CalendarPageView(vm: CalendarPageViewModel(dateWrapper: dateWrapper))
        }
    }
}
