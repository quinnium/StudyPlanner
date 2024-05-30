//
//  CalendarView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI
import SwiftData

struct CalendarPageView: View {
    
    @Bindable var vm: CalendarPageViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Page Title & Add button
            HStack {
                Text("Calendar")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button("", systemImage: "plus.circle.fill") {
                    vm.isShowingAddNewSeriesSheet = true
                }
                .font(.system(size: 25))
            }
            .padding(10)
            // Calendar
            CalendarView(vm: vm.calendarViewModel)
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
            
            // List of sessions for selected Date
            DaySessionsListView(vm: vm.sessionsListViewModel, onSheetDismiss: {
                vm.fetchData()
            })
        }
        .background {
            Color.gray.opacity(0.15)
                .ignoresSafeArea()
        }
        .onAppear {
            vm.fetchData()
        }
        .sheet(isPresented: $vm.isShowingAddNewSeriesSheet) {
            vm.fetchData()
        } content: {
            StudySeriesView(vm: vm.newStudySeriesViewModel)
        }
    }
}


#Preview {
    let modelDataSource = ModelDataSource.forTesting
    let studySeries = StudySeries(subject: "Mathematics", color: .green, notes: "This is some very long notes text, used to display a way of detecting truncation. Smooth animation should also be used here", sessions: [])
    modelDataSource.insertObject(studySeries)
    let session = StudySession(date: Date().startOfCalendarMonth)
    modelDataSource.insertObject(session)
    studySeries.sessions = [session]
    
    return CalendarPageView(vm: CalendarPageViewModel(dateWrapper: DateWrapper(dateSelected: .now), forTesting: true))
}
