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
    
    var isNewStudySeries: Bool { studySeries == nil }
    var startOfToday: Date { Calendar.current.startOfDay(for: .now) }
    let allSPColors = SPColor.allCases
    
    var subjectText: String = ""
    var notesText: String = ""
    var selectedColour: SPColor? = nil
    var studySessions: [StudySession] = []
    
    init(studySeries: StudySeries?, inTestingEnvironment: Bool = false) {
        self.studySeries = studySeries
        if let studySeries {
            configureViewFromStudySeries(studySeries)
        }
        Task {
            modelDataSource = inTestingEnvironment ? await ModelDataSource.forTesting : await ModelDataSource.shared
        }
    }
    
    func configureViewFromStudySeries(_ series: StudySeries) {
        subjectText     = series.subject
        notesText       = series.notes
        selectedColour  = series.color
        studySessions   = series.sessions
    }
    
    func addSession() {
        let lastDate    = studySessions.last?.date ?? startOfToday
        let newDate     = Calendar.current.date(byAdding: .weekday, value: 7, to: lastDate) ?? startOfToday
        let newSession = StudySession(date: newDate)
        studySessions.append(newSession)
    }
    
    func removeSession(atIndex index: Int) {
        studySessions.remove(at: index)
    }
    
    func saveStudySeries() {
        // TODO: ensure 'save' can only be tapped if a colour has been selected
        guard let selectedColour = selectedColour,
        let modelDataSource = modelDataSource else { return }
        if let studySeries {
            // Save to existing StudySeries
            studySeries.subject     = subjectText
            studySeries.notes       = notesText
            studySeries.color       = selectedColour
            // Delete existing sessions to avoid orphaned StudySessions
            for exitingSession in studySeries.sessions {
                modelDataSource.deleteObject(exitingSession)
            }
            for newSession in studySessions {
                modelDataSource.insertObject(newSession)
            }
            studySeries.sessions    = studySessions
        } else {
            // Save new StudySeries
            let newStudySeries      = StudySeries(subject: subjectText,
                                             color: selectedColour,
                                             notes: notesText,
                                             sessions: [])
            modelDataSource.insertObject(newStudySeries)
            newStudySeries.sessions = studySessions
        }
    }

}
