//
//  ModelDataSource.swift
//  StudyPlanner
//
//  Created by Quinn on 08/03/2024.
//

import Foundation
import SwiftData

final class ModelDataSource {
    
    private let container: ModelContainer
    private let context: ModelContext
    private let scratchContext: ModelContext
    
    @MainActor static let shared        = ModelDataSource(forTesting: false)
    @MainActor static let forTesting    = ModelDataSource(forTesting: true)
    
    @MainActor private init(forTesting: Bool) {
        let schema = Schema([StudySeries.self, StudySession.self])
        let config = ModelConfiguration(for: StudySeries.self, StudySession.self, isStoredInMemoryOnly: forTesting)
        do {
            self.container  = try ModelContainer(for: schema, configurations: config)
            self.context    = container.mainContext
            self.scratchContext = ModelContext(container)
            self.scratchContext.autosaveEnabled = false
        } catch {
            fatalError("Failed to load model container")
        }
    }
    
    func createTemporaryObject(_ object: any PersistentModel) {
        context.insert(object)
    }
    
    func saveAllTemporaryObjects() {
        do {
            try scratchContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func insertObject(_ object: any PersistentModel) {
        context.insert(object)
    }
    
    func deleteObject(_ object: any PersistentModel) {
        context.delete(object)
    }
    
    func fetchAllObjects<T: PersistentModel>(objectType: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>(sortBy: [])
        do {
            let objects = try context.fetch(descriptor)
            return objects
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchStudySessionsForDateRange(from fromDate: Date, to toDate: Date) -> [StudySession] {
        let descriptor = FetchDescriptor<StudySession>(
            predicate: #Predicate { $0.date >= fromDate && $0.date <= toDate },
            sortBy: [SortDescriptor(\.date), SortDescriptor(\.parentSeries?.subject)])
        do {
            let objects = try context.fetch(descriptor)
            return objects
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}


