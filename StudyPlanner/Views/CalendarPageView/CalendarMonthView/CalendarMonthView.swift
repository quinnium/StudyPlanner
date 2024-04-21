//
//  CalendarMonthView.swift
//  StudyPlanner
//
//  Created by Quinn on 08/04/2024.
//

import SwiftUI

struct CalendarMonthView: View {
    
    @Bindable var vm: CalendarMonthViewModel
    
    var body: some View {
        VStack {
            // Date Selector
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(0..<vm.offsetDaysAtStartOfMonth, id:\.self) { _ in
                    Color.clear
                }
                ForEach(vm.allDatesInMonth, id: \.self) { date in
                    CalendarDayView(selectedDate: $vm.dateWrapper.dateSelected, date: date, colors: [])
                        .frame(height: 50)
                }
            }
        }
        .onAppear {
            vm.fetchSessionsForMonth()
        }
    }
}

#Preview {
    CalendarMonthView(vm: CalendarMonthViewModel(dateWrapper: .init(dateSelected: .now, monthDate: .now)))
}
