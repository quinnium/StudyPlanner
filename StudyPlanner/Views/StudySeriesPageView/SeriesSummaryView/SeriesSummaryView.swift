//
//  SeriesSummaryView.swift
//  StudyPlanner
//
//  Created by Quinn on 05/05/2024.
//

import SwiftUI
import SwiftData

struct SeriesSummaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let vm: SeriesSummaryViewModel

    var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(vm.series.subject)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                    Spacer()
                    Text(vm.completedSessions.description)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                    Image(systemName: "checkmark")
                        .bold()
                        .scaleEffect(0.8)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleSecondarytTextDark : vm.color.spStyleSecondaryText)
                    Text(" / ")
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                    Text(vm.series.sessions.count.description)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                    Image(systemName: "book")
                        .bold()
                        .scaleEffect(0.8)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleSecondarytTextDark : vm.color.spStyleSecondaryText)
                }
                .font(.system(size: 16))
                
                if vm.series.notes.isNotEmpty {
                    ExpandableTextView(textString: vm.series.notes)
                        .font(.footnote)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleSecondarytTextDark : vm.color.spStyleSecondaryText)
                }
                    
                if vm.overdueSessions.isNotEmpty {
                    Text(vm.overdueSessionText)
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                }
                
                if vm.upcomingSessions.isNotEmpty {
                    Text(vm.upcomingSessionsText)
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                }
                
                if vm.allSessionsCompleted {
                    Text("All study sessions completed")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)

                }
            }
            .padding(8)
            .background() {
                ZStack {
                    if vm.allSessionsCompleted {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(vm.color, lineWidth: 3)
                            // allows clear background to be tappable
                            .contentShape(Rectangle())
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(colorScheme == .dark ? vm.color.spStyleBackgroundDark : vm.color.spStyleBackground)
                    }
                }
            }
            .opacity(vm.allSessionsCompleted ? 0.6 : 1)
    }
}

#Preview {
    let modelDataSource = ModelDataSource.forTesting
    for color in SPColor.allCases {
        let session = StudySession(date: Date())
        var studySeries = StudySeries(subject: "Mathematics", color: color, notes: "This is some very long notes text, used to display a way of detecting truncation. Smooth animation should also be used here", sessions: [])
        modelDataSource.insertObject(studySeries)
        modelDataSource.insertObject(session)
        studySeries.sessions = [session]
    }
    let allSeries = modelDataSource.fetchAllObjects(objectType: StudySeries.self)
    
    return ScrollView {
        ForEach(allSeries.sorted(by: { $0.color.rawValue < $1.color.rawValue })) { series in
            SeriesSummaryView(vm: .init(series: series))
        }
    }
}
