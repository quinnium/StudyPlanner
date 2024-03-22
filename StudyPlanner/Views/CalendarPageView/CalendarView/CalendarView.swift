//
//  CalendarView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI
import SwiftData

// TODO: test calednar UI doesn't jump up when a month has more weeks in it
struct CalendarView: View {

    @State var vm: CalendarViewModel

    init(modelContext: ModelContext, date: Date) {
        self.vm = CalendarViewModel(modelContext: modelContext, date: date)
    }

    var body: some View {
        VStack {
            // Month & Year
            HStack {
                Button {
                    print("Tapped!")
                } label: {
                    Text(vm.monthAndYear)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.right")
                }

                Spacer()

                Button {
                    vm.prevMonth()
                } label: {
                    Image(systemName: "chevron.left")
                }

                Button {
                    vm.nextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                }

            }
            .padding()

            // Days
            HStack(spacing: 0) {
                ForEach(SPDays.allDays, id: \.self) { spDay in
                    Text(spDay.veryshortName)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
            }

            // Date Selector
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<vm.bufferDaysCount, id:\.self) { _ in
                    Color.clear
                }
                ForEach(vm.allDatesInMonth, id:\.self) { date in
                    SPDatePickerDay(date: date, studySessionColors: [])
                }
                .frame(height: 40)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StudySeries.self, configurations: config)
    let context = container.mainContext
    
    return CalendarView(modelContext: context, date: .now)
}


struct SPDatePickerDay: View{

    let date: Date
    let calendar = Calendar.current
    let studySessionColors: [SPColor]
    
    var body: some View {
        VStack {
            Text(calendar.component(.day, from: date).description)
                .foregroundColor(.black)
        }
    }
}


