//
//  SeriesSummaryView.swift
//  StudyPlanner
//
//  Created by Quinn on 05/05/2024.
//

import SwiftUI
import SwiftData

struct SeriesSummaryView: View {
    let vm: SeriesSummaryViewModel
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(vm.series.subject)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .font(.title3)
                        .foregroundStyle(Color.from(spColor: vm.series.color)).brightness(-0.3)
                    Spacer()
                    Text(vm.sessionsCompleted.description)
                    Image(systemName: "checkmark")
                        .bold()
                        .scaleEffect(0.8)
                        .opacity(0.3)
                    Text(" / ")
                    Text(vm.series.sessions.count.description)
                    Image(systemName: "book")
                        .bold()
                        .scaleEffect(0.8)
                        .opacity(0.3)
                }
                .font(.system(size: 16))
                .foregroundStyle(Color.from(spColor: vm.series.color)).brightness(-0.3)
                
                if vm.series.notes.isNotEmpty {
                    ExpandableTextView(textString: vm.series.notes, minLines: 1)
                        .font(.footnote)
                        .foregroundStyle(Color.from(spColor: vm.series.color)).brightness(-0.3).opacity(0.6)
                }
            }
            .padding(8)
            .background() {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.from(spColor: vm.series.color).opacity(0.2))
            }
    }
}

#Preview {
    
    let modelDataSource = ModelDataSource.forTesting
    
    @State var session = StudySession(date: Date())
    modelDataSource.insertObject(session)
    @State var studySeries = StudySeries(subject: "Mathematics", color: .green, notes: "This is some very long notes text, used to display a way of detecting truncation. Smooth animation should also be used here", sessions: [])
    modelDataSource.insertObject(studySeries)
    studySeries.sessions = [session]
    
    return SeriesSummaryView(vm: .init(series: studySeries))
        .modelContainer(for: [StudySeries.self])
}
