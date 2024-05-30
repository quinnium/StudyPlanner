//
//  SessionSummaryView.swift
//  StudyPlanner
//
//  Created by Quinn on 17/05/2024.
//

import SwiftUI

struct SessionSummaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Bindable var vm: SessionSummaryViewModel
    
    var body: some View {
        HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text(vm.subject)
                            .lineLimit(2)
                            .minimumScaleFactor(0.6)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                        Spacer()
                    }
                    .font(.system(size: 16))
                    
                    if vm.notes.isNotEmpty {
                        ExpandableTextView(textString: vm.notes)
                            .font(.footnote)
                            .foregroundStyle(colorScheme == .dark ? vm.color.spStyleSecondarytTextDark : vm.color.spStyleSecondaryText)
                    }
                    Text(vm.sessionInfoText)
                        .font(.footnote)
                        .foregroundStyle(colorScheme == .dark ? vm.color.spStyleMainTextDark : vm.color.spStyleMainText)
                }
                CompleteSessionView(isComplete: $vm.session.isCompleted, text: "", size: 25, color: .primary)
            }
            .padding(8)
            .background() {
                ZStack {
                    if vm.session.isCompleted {
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
            .opacity(vm.session.isCompleted ? 0.6 : 1)
    }
}

#Preview {
    let modelDataSource = ModelDataSource.forTesting
    var session = StudySession(date: Date(), isCompleted: false)
    modelDataSource.insertObject(session)
    var studySeries = StudySeries(subject: "Mathematics", color: .pink, notes: "This is some very long notes text, used to display a way of detecting truncation. Smooth animation should also be used here", sessions: [])
    modelDataSource.insertObject(studySeries)
    studySeries.sessions = [session]
    
    return SessionSummaryView(vm: SessionSummaryViewModel(session: session))
}
