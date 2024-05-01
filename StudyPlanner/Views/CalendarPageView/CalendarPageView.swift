//
//  CalendarView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI

struct CalendarPageView: View {
    
    @Bindable var vm: CalendarPageViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 20)
                VStack(spacing: 0) {
                    CalendarHeaderView(vm: vm.calendarHeaderViewModel)
                    
                    // Calenday Month Days
                    CalendarMonthView(vm: vm.calendarMonthViewModel)
                }
                .padding(.horizontal, 4)
                .background {
                    Color(uiColor: .systemBackground)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)

                // List of sessions for selected Date
                SessionsListView(vm: vm.sessionsListViewModel, onDismiss: {
                    vm.fetchData()
                })
                    .padding(.vertical, 10)
            }
            .navigationTitle("Study Planner")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        vm.isShowingAddNewSeriesSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $vm.isShowingAddNewSeriesSheet) {
            vm.fetchData()
        } content: {
            StudySeriesView(vm: vm.newStudySeriesViewModel)
        }
    }
}

#Preview {
    CalendarPageView(vm: CalendarPageViewModel(dateWrapper: DateWrapper(dateSelected: .now)))
}
