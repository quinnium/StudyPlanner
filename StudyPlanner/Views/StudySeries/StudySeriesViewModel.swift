//
//  StudySeriesViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 08/03/2024.
//

import Foundation
//import SwiftData

@Observable
final class StudySeriesViewModel {
    
    @ObservationIgnored
    private var modelDataSource: ModelDataSource?
    private var studySeries: StudySeries?
    private var dateSelected: Date?
    
    var isNewStudySeries: Bool { studySeries == nil }
    var startOfToday: Date { Calendar.current.startOfDay(for: .now) }
    let allSPColors = SPColor.allCases
    
    var subjectText: String = ""
    var notesText: String = ""
    var selectedColour: SPColor? = nil
    var studySessions: [StudySession] = []
    var isValidToSave: Bool {
        return !subjectText.isEmpty && !studySessions.isEmpty && selectedColour != nil
    }
    var sessionsOutOfDateOrder: Bool {
        studySessions != studySessions.sorted { $0.date < $1.date }
    }
    
    init(studySeries: StudySeries?, selectedDate: Date? = .now, inTestingEnvironment: Bool = false) {
        self.studySeries = studySeries
        self.dateSelected = selectedDate
        if let studySeries {
            configureViewFromStudySeries(studySeries)
        } else {
            addSession()
        }
        Task {
            modelDataSource = inTestingEnvironment ? await ModelDataSource.forTesting : await ModelDataSource.shared
        }
    }
    
    func configureViewFromStudySeries(_ series: StudySeries) {
        subjectText     = series.subject
        notesText       = series.notes
        selectedColour  = series.color
        studySessions   = series.sessions.sorted { $0.date < $1.date }.map { StudySession(date: $0.date, isCompleted: $0.isCompleted)}
    }
    
    func addSession() {
        var newDate = Date()
        if let lastDate = studySessions.last?.date {
            newDate = Calendar.current.date(byAdding: .weekday, value: 1, to: lastDate) ?? startOfToday
        } else {
            newDate = dateSelected ?? startOfToday
        }
        let newSession = StudySession(date: newDate)
        studySessions.append(newSession)
    }
    
    func reOrderStudySessions() {
        studySessions.sort { $0.date < $1.date }
    }
    
    func removeSession(atIndex index: Int) {
        studySessions.remove(at: index)
    }
    
    func saveStudySeries() {
        guard let selectedColour = selectedColour,
        let modelDataSource = modelDataSource else { return }
        if let studySeries {
            // Save to existing StudySeries
            studySeries.subject     = subjectText
            studySeries.notes       = notesText
            studySeries.color       = selectedColour
            // Delete existing sessions to avoid orphaned StudySessions
            for oldSession in studySeries.sessions {
                modelDataSource.deleteObject(oldSession)
            }
//            studySeries.sessions.removeAll()
            for newSession in studySessions {
                modelDataSource.insertObject(newSession)
            }
            studySeries.sessions    = studySessions.sorted { $0.date < $1.date }
        } else {
            // Save new StudySeries
            let newStudySeries      = StudySeries(subject: subjectText,
                                             color: selectedColour,
                                             notes: notesText,
                                             sessions: [])
            modelDataSource.insertObject(newStudySeries)
            newStudySeries.sessions = studySessions.sorted { $0.date < $1.date }
        }
    }

}
