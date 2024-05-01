//
//  CalendarHeaderView.swift
//  StudyPlanner
//
//  Created by Quinn on 28/04/2024.
//

import SwiftUI

struct CalendarHeaderView: View {
    
    var vm: CalendarHeaderViewModel
    
    var body: some View {
        VStack {
            // Buttons
            HStack(spacing: 20) {
                Button("Today") {
                    vm.goToToday()
                }
                Spacer()
                Button("", systemImage: "chevron.left") {
                    vm.prevMonth()
                }
                Button(vm.monthAndYearText) {
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
        }
    }
}

#Preview {
    CalendarHeaderView(vm: CalendarHeaderViewModel(dateWrapper: .init(dateSelected: .now)))
}
