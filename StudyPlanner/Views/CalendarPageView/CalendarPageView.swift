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
                    // Buttons
                    HStack(spacing: 20) {
                        Button("Today") {
                            vm.goToToday()
                        }
                        Spacer()
                        Button("", systemImage: "chevron.left") {
                            vm.prevMonth()
                        }
                        Button(vm.monthAndYear) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                vm.yearMonthSelectorDisplayed.toggle()
                            }
                        }
                        Button("", systemImage: "chevron.right") {
                            vm.nextMonth()
                        }
                    }
                    .padding(20)
                    .background(Color(uiColor: .systemBackground))
                    
                    // Year & Month picker
                    if vm.yearMonthSelectorDisplayed {
                        YearMonthPickerView(vm: vm.yearMonthPickerViewModel)
                            .zIndex(-100)
                            .transition(.move(edge: .top))
                    }
                    
                    // Calenday Month Days
                    CalendarMonthDatesView(vm: vm.calendarMonthViewModel)
                }
                .background {
                    Color(uiColor: .systemBackground)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 2)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)

                //List of sessions for selected Date
                SessionsListView(vm: vm.sessionsListViewModel)
                    .padding(.vertical, 10)
            }
            .navigationTitle("Study Planner")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        vm.isShowingAddNewStudySheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $vm.isShowingAddNewStudySheet) {
            StudySeriesView(vm: StudySeriesViewModel(studySeries: nil))
        }
        .sheet(item: $vm.selectedStudySeries) { studySeries in
            StudySeriesView(vm: StudySeriesViewModel(studySeries: studySeries))
        }
    }
}

#Preview {
    CalendarPageView(vm: CalendarPageViewModel())
}
