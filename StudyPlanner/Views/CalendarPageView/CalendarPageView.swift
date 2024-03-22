//
//  CalendarPageView.swift
//  StudyPlanner
//
//  Created by Quinn on 24/02/2024.
//

import SwiftUI
import SwiftData
import Observation

struct CalendarPageView: View {
    
    @State var vm = CalendarPageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                List(vm.studySeries) { series in
                    Button(series.subject) {
                        vm.selectedStudySeries = series
                    }
                }
                Button("Refresh") {
                    vm.fetchItems()
                }.padding()
//                CalendarView(modelContext: modelContext, date: Date())
            }
            .navigationDestination(for: StudySeries.self) { series in
                StudySeriesView(vm: StudySeriesViewModel(studySeries: series))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        vm.isShowingAddNewStudySheet = true
                    }
                }
            }
            .onAppear {
                vm.fetchItems()
            }
        }
        .sheet(isPresented: $vm.isShowingAddNewStudySheet, content: {
            StudySeriesView(vm: StudySeriesViewModel(studySeries: nil))
        })
        .sheet(item: $vm.selectedStudySeries) { studySeries in
            StudySeriesView(vm: StudySeriesViewModel(studySeries: studySeries))
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StudySeries.self, configurations: config)
    let context = container.mainContext
    return CalendarPageView()
}
