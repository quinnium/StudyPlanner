//
//  CalendarDayView.swift
//  StudyPlanner
//
//  Created by Quinn on 12/03/2024.
//

import SwiftUI

struct CalendarDayView: View {
    
    @Binding var selectedDate: Date
    let date: Date
    let completedColors: [Color]
    let incompletedColors: [Color]
    let calendar = Calendar.autoupdatingCurrent
    var isSelectedDate: Bool {
        date == selectedDate
    }
    var isToday: Bool {
        calendar.isDate(date, inSameDayAs: .now)
    }
    
    var body: some View {
        ZStack {
            if isSelectedDate {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue, lineWidth: 2)
                            .opacity(0.75)
                    }
            }
            if isToday {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.secondary).opacity(0.7)
                    .opacity(0.3)
            }
            Text((calendar.component(.day, from: date)).description)
                    .foregroundColor(.primary)
            // completed Session Ticks
            HStack(spacing: 1) {
                ForEach(0..<completedColors.count, id:\.self) { index in
                    if index < 3 {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .heavy))
                            .foregroundStyle(completedColors[index])
                    } else if index == 3 {
                        Image(systemName: "plus")
                            .font(.system(size: 10))
                            .padding(0)
                            .frame(width: 10)
                    }
                }
            }
            .offset(y: -18)
            // incompleted Session circles
            HStack(spacing: 1) {
                ForEach(0..<incompletedColors.count, id:\.self) { index in
                    if index < 3 {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(incompletedColors[index])
                    } else if index == 3 {
                        Image(systemName: "plus")
                            .font(.system(size: 10))
                            .padding(0)
                            .frame(width: 10)
                    }
                }
            }
            .offset(y: 18)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            selectedDate = date
        }
    }
}

#Preview {
    CalendarDayView(selectedDate: .constant(.now), date: .now, completedColors: [.red, .green, .blue, .orange], incompletedColors: [.purple, .blue, .red, .yellow])
}
