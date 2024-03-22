//
//  CalendarViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI
import SwiftData

@Observable
class CalendarViewModel {
    
    var modelContext: ModelContext
    let calendar = Calendar.autoupdatingCurrent
    let dateFormatter = DateFormatter()
    
    var date: Date
    var studySeries: [StudySeries] = []
    
    var monthAndYear: String {
        dateFormatter.string(from: date)
    }
    
    var bufferDaysCount: Int {
        return abs(date.firstWeekDayOfMonth() - SPDays.firstDayInt)
    }

    var allDatesInMonth: [Date] {
        date.allDatesInMonth()
    }
    
    init(modelContext: ModelContext, date: Date) {
        self.modelContext = modelContext
        dateFormatter.dateFormat = "MMMM yyyy"
        self.date = date
        fetchAllStudySessions()
    }
    
    func nextMonth() {
        date = calendar.date(byAdding: .month, value: 1, to: date) ?? date
    }
    
    func prevMonth() {
        date = calendar.date(byAdding: .month, value: -1, to: date) ?? date
    }
    
    func fetchAllStudySessions() {
        let descriptor = FetchDescriptor<StudySeries>()
        do {
            studySeries = try modelContext.fetch(descriptor)
            print("\(studySeries.count) series fetched")
        } catch {
            print(error.localizedDescription)
        }   
    }
    
    func getSessionsForDate(date: Date) -> [Date] {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let scratchContext = try! ModelContainer(for: StudySeries.self, configurations: config)
        
        return []
    }
}

