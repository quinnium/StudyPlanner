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
            // Weekdays
            HStack(spacing: 0) {
                ForEach(SPDays.allDays, id: \.self) { spDay in
                    Text(spDay.veryshortName)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
            }
            .padding(.vertical, 10)
            
            // Month days
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 1) {
                // Prefix 'gap' dates
                ForEach(0..<vm.offsetDaysAtStartOfMonth, id:\.self) { _ in
                    Color.clear
                }
                // Month dates
                ForEach(vm.allDatesInMonth, id: \.self) { date in
                    let completedSessionColorsForDate = Array(vm.completedSessionColorsDict[date] ?? []).sorted { $0.description < $1.description }
                    let incompletedSessionColorsForDate = Array(vm.incompletedSessionColorsDict[date] ?? []).sorted { $0.description < $1.description }
                    CalendarDayView(selectedDate: $vm.dateWrapper.dateSelected, date: date, completedColors: completedSessionColorsForDate, incompletedColors: incompletedSessionColorsForDate)
                        .frame(height: 50)
                }
            }
            .padding(.bottom, 5)
        }
    }
}

#Preview {
    CalendarMonthView(vm: CalendarMonthViewModel(dateWrapper: .init(dateSelected: .now), sessionsForMonth: []))
}
