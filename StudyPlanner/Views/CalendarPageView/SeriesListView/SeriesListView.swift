//
//  SeriesListView.swift
//  StudyPlanner
//
//  Created by Quinn on 12/05/2024.
//

import SwiftUI
import SwiftData

struct SeriesListView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var vm: SeriesListViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.allSeries) { series in
                    SeriesSummaryView(vm: SeriesSummaryViewModel(series: series))
                        .onTapGesture {
                            vm.selectedSeriesForEditing = series
                        }
                }
                Spacer()
            }
            .navigationTitle("All Subjects")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        
        .sheet(item: $vm.selectedSeriesForEditing) {
            vm.fetchSeries()
        } content: { series in
            StudySeriesView(vm: vm.studySeriesViewModel)
        }
    }
}

#Preview {
    let modelDataSource = ModelDataSource.forTesting
    let newSeries1 = StudySeries(subject: "Mathematics",
                                 color: .blue,
                                 notes: "This is a simple note for this series",
                                 sessions: [])
    let newSeries2 = StudySeries(subject: "Mathematics",
                                 color: .green,
                                 notes: "This is an example of a very long notes text that requires multiple lines and will be truncated (if not expanded)",
                                 sessions: [])
    modelDataSource.insertObject(newSeries1)
    modelDataSource.insertObject(newSeries2)
    let session1 = StudySession(date: .now,
                                parentSeries: newSeries1,
                                isCompleted: true)
    let session2 = StudySession(date: .distantFuture,
                                parentSeries: newSeries1,
                                isCompleted: false)
    let session3 = StudySession(date: .distantPast,
                                parentSeries: newSeries2,
                                isCompleted: false)
    let session4 = StudySession(date: .now,
                                parentSeries: newSeries2,
                                isCompleted: true)
    modelDataSource.insertObject(session1)
    modelDataSource.insertObject(session2)
    modelDataSource.insertObject(session3)
    modelDataSource.insertObject(session4)
    
    return SeriesListView(vm: SeriesListViewModel(forTesting: true))
}
