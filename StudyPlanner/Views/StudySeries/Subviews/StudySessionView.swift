//
//  StudySessionView.swift
//  StudyPlanner
//
//  Created by Quinn on 24/02/2024.
//

import SwiftUI
import SwiftData


struct StudySessionView: View {
        
    @Binding var session: StudySession
    let isNewSeries: Bool
    
    let index: Int
    let color: Color
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(color.opacity(session.isCompleted ? 0.1 : 0.2))
            VStack(spacing:10) {
                HStack{
                    Button("", systemImage: "xmark") {
                        withAnimation {
                            onDelete()
                        }
                    }
                    .foregroundStyle(color)
                    .brightness(-0.3)
                    Spacer()
                    Text("Session \(index + 1)")
                        .font(.headline)
                        .foregroundStyle(color)
                        .brightness(-0.3)
                }
                DatePicker("Session Date", selection: $session.date, in: Constants.Dates.allowableDateRange, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(color)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
            }
            .padding(10)
            .opacity(session.isCompleted ? 0.5 : 1)
            .overlay(alignment: .bottomTrailing) {
                if !isNewSeries {
                    HStack {
                        CompleteSessionView(isComplete: $session.isCompleted, text: "Completed", size: 17, color: color)
                            .brightness(-0.3)
                            .padding(5)
                    }
                }
            }
        }
    }
}

#Preview {
    let container: ModelContainer = {
        let schema = Schema([StudySeries.self, StudySession.self])
        let config = ModelConfiguration(for: StudySeries.self, StudySession.self, isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: config)
            return container
        } catch {
            fatalError("Failed to load model container")
        }
    }()
    
    @State var session = StudySession(date: Date())
    container.mainContext.insert(session)
    @State var studySeries = StudySeries(subject: "test", color: .blue, notes: "", sessions: [])
    container.mainContext.insert(studySeries)
    studySeries.sessions = [session]
    return StudySessionView(session: $session, isNewSeries: false, index: 1, color: .pink, onDelete: {})
        .frame(width: 200, height: 150)
}
