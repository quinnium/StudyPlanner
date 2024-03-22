//
//  StudySeriesViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 08/03/2024.
//

import Foundation
import SwiftData

@Observable
final class StudySeriesViewModel {
    
    @ObservationIgnored
    private var modelDataSource: ModelDataSource?
    private var studySeries: StudySeries?
    
    var isNewStudySeries: Bool { studySeries == nil }
    let allSPColors = SPColor.allCases
    
    var subjectText: String = ""
    var notesText: String = ""
    var selectedColour: SPColor? = nil
    var studySessions: [StudySession] = []
    
    init(studySeries: StudySeries?, forTestingEnvironment: Bool = false) {
        self.studySeries = studySeries
        if let studySeries {
            configureViewFromStudySeries(studySeries)
        }
        Task {
            modelDataSource = forTestingEnvironment ? await ModelDataSource.forTesting : await ModelDataSource.shared
        }
    }
    
    func configureViewFromStudySeries(_ series: StudySeries) {
        subjectText     = series.subject
        notesText       = series.notes
        selectedColour  = series.color
        // TODO: check that these sessions are a COPY of the object's sessions, not the actual ones
        studySessions   = series.sessions
    }
    
    func addSession() {
        let lastDate    = studySessions.last?.date ?? Date()
        let newDate     = Calendar.current.date(byAdding: .weekday, value: 7, to: lastDate) ?? Date()
        let newSession = StudySession(date: newDate)
        studySessions.append(newSession)
    }
    
    func removeSession(atIndex index: Int) {
        studySessions.remove(at: index)
    }
    
    func saveStudySeries() {
        // TODO: ensure 'save' can only be tapped if a colour has been selected
        guard   let selectedColour = selectedColour,
        let modelDataSource = modelDataSource else { return }
        if let studySeries {
            // Save to existing StudySeries
            studySeries.subject     = subjectText
            studySeries.notes       = notesText
            studySeries.color       = selectedColour
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
