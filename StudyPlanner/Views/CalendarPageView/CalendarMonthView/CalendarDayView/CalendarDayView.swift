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
    let colors: [Color]
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
                    .foregroundStyle(Color.secondary)
                    .opacity(0.3)
            }
            HStack(spacing: 0) {
                Text((calendar.component(.day, from: date)).description)
                    .foregroundColor(.primary)
            }
            HStack(spacing: 1) {
                ForEach(0..<colors.count, id:\.self) { index in
                    if index < 3 {
                        Circle()
                            .foregroundStyle(colors[index])
                            .frame(width: 10)
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
    CalendarDayView(selectedDate: .constant(.now), date: .now, colors: [.red, .green, .blue])
}
