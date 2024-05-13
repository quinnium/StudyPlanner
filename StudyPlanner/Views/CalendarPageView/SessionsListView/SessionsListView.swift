//
//  SessionsListView.swift
//  StudyPlanner
//
//  Created by Quinn on 22/04/2024.
//

import SwiftUI

struct SessionsListView: View {
    
    @Bindable var vm: SessionsListViewModel
    var onDismiss: () -> Void
    
    var body: some View {
        ScrollView {
            ForEach($vm.sessions, id: \.id) { session in
                if let parentSeries = session.wrappedValue.parentSeries {
                    HStack {
                        Button {
                            vm.selectedSeriesForEditing = parentSeries
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: session.wrappedValue.isCompleted ? "checkmark" : "circle.fill")
                                    .foregroundStyle(Color.from(spColor: parentSeries.color))
                                    .font(.system(size: 20, weight: .heavy))
                                VStack(alignment: .leading) {
                                    Text(parentSeries.subject)
                                        .foregroundStyle(session.wrappedValue.isCompleted ? .secondary : .primary)
                                        .strikethrough(session.wrappedValue.isCompleted, color: .secondary)
                                    Text(vm.getSessionInfoText(session: session.wrappedValue))
                                        .foregroundStyle(.secondary)
                                        .font(.caption)
                                        .italic()
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        Spacer()
                        CompleteSessionView(isComplete: session.isCompleted,text: "", size: 25, color: .primary)
                    }
                    .padding(.horizontal)
                }
            }
            .animation(.easeIn(duration: 0.2), value: vm.sessions.map {$0.isCompleted})
            
        }
        .sheet(item: $vm.selectedSeriesForEditing) {
            onDismiss()
        } content: { series in
            StudySeriesView(vm: vm.studySeriesViewModel)
        }

    }
}

#Preview {
    SessionsListView(vm: .init(sessions: []), onDismiss: {})
}
